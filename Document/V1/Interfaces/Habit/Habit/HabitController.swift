//
//  HabitController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitController: ViewController, CalendarViewDelegate, UIScrollViewDelegate {
    
    // MARK: - Data
    
    var show: HabitShow!

    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar_view.collection.reloadData()
        deploy_scroll_view()
        deploy_information()
        calendar_view(select: Date())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, animations: {
            self.update_scroll_view_size()
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - Information View
    
    @IBOutlet weak var information_view: UIView!
    @IBOutlet weak var information_layout_top: NSLayoutConstraint!
    
    @IBOutlet weak var habit_name_label: UILabel!
    @IBOutlet weak var habit_frequency_label: UILabel!
    @IBOutlet weak var habit_time_label: UILabel!
    
    private func deploy_information() {
        habit_name_label.text = show.habit.name
        habit_frequency_label.text = show.habit.frequency()
        habit_time_label.text = show.habit.total_duration()
    }
    
    // MARK : - Scroll View
    
    @IBOutlet weak var scroll_view: UIScrollView!
    
    /** 配置滚动视图以及其内部的所有视图 */
    func deploy_scroll_view() {
        scroll_view.frame = CGRect(
            x: 0, y: 110,
            width: width,
            height: height - 110
        )
        calendar_view.delegate = self
        scroll_view.addSubview(calendar_view)
        
        scroll_view.addSubview(menu_view)
        
        scroll_view.contentSize = scroll_view.bounds.size
        update_scroll_view_size()
    }
    
    /** 更新滚动视图的位置 */
    func update_scroll_view_size() {
        scroll_view.contentSize = CGSize(
            width: width,
            height: scroll_view.bounds.height + 1
        )
        var y: CGFloat = 1
        
        calendar_view.frame = CGRect(
            x: 20, y: y,
            width: scroll_view.bounds.width - 40,
            height: scroll_view.bounds.height - 60
        )
        y = calendar_view.frame.maxY
        
        menu_view.frame = CGRect(
            x: 0, y: y,
            width: scroll_view.bounds.width,
            height: 60
        )
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.information_layout_top.constant = scrollView.contentOffset.y < 0 ? -scrollView.contentOffset.y : 0 
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -100 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: - Calendar View
    
    @IBOutlet var calendar_view: CalendarView!
    
    // MARK: CalendarViewDelegate
    
    func calendar_view(select date: Date) {
        let logs = show.logs(date: date.today)
        var time = 0
        logs.forEach({ time += $0.duration })
        calendar_view.left_label.text = "clock \(logs.count) times"
        calendar_view.right_label.text = "spend \(time.time)"
    }
    
    func calendar_view_open_note_list() {
        performSegue(withIdentifier: "HabitLogsController", sender: nil)
    }
    
    func calendar_view_append_unnote() {
        let log = HabitLog(
            habit: show.habit,
            type: .absence,
            date: calendar_view.date.advance(time: TimeInterval(Date().times))
        )
        if log.id == -1 {
            log.table_delete()
            return
        }
        show.calendar[log.date] = (show.calendar[log.date] ?? []) + [log]
        calendar_view(select: calendar_view.date)
        calendar_view.collectionView_update_cell()
        deploy_information()
    }
    
    func calendar_view_append_note() {
        let log = HabitLog(
            habit: show.habit,
            type: .present,
            date: calendar_view.date.advance(time: TimeInterval(Date().times))
        )
        if log.id == -1 {
            log.table_delete()
            return
        }
        show.calendar[log.date] = (show.calendar[log.date] ?? []) + [log]
        calendar_view(select: calendar_view.date)
        calendar_view.collectionView_update_cell()
        deploy_information()
    }
    
    func calendar_view_cell_is_light_on_date(_ date: Date) -> Bool {
        return show.is_done(date: date)
    }
    
    func calendar_view_cell_is_absence(date: Date) -> Bool {
        return show.is_absence(date: date)
    }
    
    // MARK: - Menu View
    
    @IBOutlet weak var menu_view: UIView!
    
    @IBAction func edit_habit_action(_ sender: UIButton) {
        
    }
    
    @IBAction func edit_cards_action(_ sender: UIButton) {
        
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HabitLogsController {
            controller.habit = show.habit
            controller.date = calendar_view.date.today
        }
    }
    
}
