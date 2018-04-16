//
//  Calendar.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate: class {
    func calendar_view(select date: Date)
    func calendar_view_append_note()
    func calendar_view_append_unnote()
    func calendar_view_open_note_list()
    
    func calendar_view_cell_is_light_on_date(_ date: Date) -> Bool
    func calendar_view_cell_is_absence(date: Date) -> Bool
}

class CalendarView: View, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: CalendarViewDelegate?
    
    // MARK: - Date
    
    var date: Date = Date()
    var first_day: Date = Date()
    
    /** 重新加载数据信息 */
    func reload_datas() {
        first_day = date.first_day_in_month()!.first_day_in_week()!
        
        month?.setTitle("\(Calendar.months[date.month - 1]) \(date.year)", for: .normal)
        
        collection?.reloadData()
    }
    
    /** 获取偏移后的日期 */
    func day_offset(_ index: Int) -> Date {
        let offset = TimeInterval(index) * 86400
        return first_day.advance(time: offset)
    }
    
    // MARK: - View Values
    
    /**  */
    @IBInspectable
    var corner: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = corner
        }
    }
    
    // MARK: - Deploy
    
    override func view_deploy() {
        super.view_deploy()
        date = Date().first_time_in_day()!
        reload_datas()
    }
    
    // MARK: - Frame
    
    var item_size: CGSize = CGSize(width: 50, height: 50)
    
    override func view_bounds() {
        item_size = CGSize(
            width: (collection.bounds.width - 7) / 7,
            height: (collection.bounds.height - 4) / 5
        )
        collection.reloadData()
    }
    
    // MARK: - Months
    
    @IBOutlet weak var month: UIButton! {
        didSet {
            month?.setTitle("\(Calendar.months[date.month - 1]) \(date.year)", for: .normal)
        }
    }
    @IBOutlet weak var last_month: UIButton!
    @IBOutlet weak var next_month: UIButton!
    
    @IBAction func month_action(_ sender: UIButton) {
        let open = self.month_selector_layout_height.constant == 0
        if !open {
            let day = self.date.day
            self.date = self.month_Selector.date
            if date.days_in_month >= day {
                date = date.advance(time: TimeInterval(day - 1) * 86400)
            }
            self.reload_datas()
            self.delegate?.calendar_view(select: date)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.month_selector_layout_height.constant = open ? self.collection.bounds.height + self.week_days.first!.bounds.height : 0
            self.layoutIfNeeded()
        }, completion: { _ in
            if open {
                self.month_Selector?.year_selector?.move_to_index(self.date.year - 2018)
                self.month_Selector?.month_selector?.move_to_index(self.date.month - 1)
            }
        })
    }
    
    // MARK: Offset
    
    @IBAction func last_month_action(_ sender: UIButton) {
        let day = date.day
        date = date.first_day_in_month()!.advance(time: -86400).first_day_in_month()!
        if date.days_in_month >= day {
            date = date.advance(time: TimeInterval(day - 1) * 86400)
        }
        reload_datas()
        delegate?.calendar_view(select: date)
    }
    @IBAction func next_month_action(_ sender: UIButton) {
        let day = date.day
        date = date.first_day_in_month()!.advance(time: TimeInterval(date.days_in_month) * 86400)
        if date.days_in_month >= day {
            date = date.advance(time: TimeInterval(day - 1) * 86400)
        }
        reload_datas()
        delegate?.calendar_view(select: date)
    }
    
    // MARK: - Month Selector
    
    @IBOutlet weak var month_Selector: MonthSelector!
    @IBOutlet weak var month_selector_layout_height: NSLayoutConstraint!
    
    // MARK: - Week Days
    
    @IBOutlet var week_days: [UIButton]!
    
    @IBAction func week_days_action(_ sender: UIButton) {
        
    }
    
    // MARK: - Days
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.register(UINib(nibName: "CalendarCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        }
    }
    
    // MARK: Current Cell
    
    /** 当前日期所选的 Cell */
    weak var date_cell: CalendarCell?
    
    /** 更新当前的 Cell */
    func update_current_cell() {
        
    }
    
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCell
        cell.view = self
        cell.index = indexPath
        
        let day = day_offset(indexPath.row)
        collectionView_update_cell(cell, day: day, update_date_cell: true)
        return cell
    }
    
    func collectionView_update_cell(_ c: CalendarCell? = nil, day d: Date? = nil, update_date_cell: Bool = false) {
        let cell = c ?? date_cell
        let day = d ?? date
        cell?.day.text = day.string(format: "d")
        
        if day.month == date.month {
            if day.day == date.day {
                cell?.date_status = .today
                if update_date_cell {
                    date_cell = cell
                }
            } else {
                cell?.date_status = .normal
            }
        } else {
            cell?.date_status = .other
        }
        
        if true == delegate?.calendar_view_cell_is_absence(date: day) {
            cell?.status = .absence
        } else if true == delegate?.calendar_view_cell_is_light_on_date(day) {
            cell?.status = .done
        } else {
            cell?.status = .none
        }
        
        cell?.update_status()
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return item_size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        let select = day_offset(indexPath.row)
        if select.month == date.month {
            date_cell?.date_status = .normal
            date_cell?.update_status()
            date_cell = cell
            
            cell.date_status = .today
            cell.update_status()
            
            date = select
            delegate?.calendar_view(select: date)
        }
    }
    
    // MARK: - Infos
    
    @IBOutlet weak var left_label: UILabel!
    @IBOutlet weak var right_label: UILabel!
    
    // MARK: - Actions
    
    @IBOutlet weak var note_button: UIButton!
    @IBAction func note_action(_ sender: UIButton) {
        delegate?.calendar_view_append_note()
    }
    
    @IBOutlet weak var unnote_button: UIButton!
    @IBAction func unnote_action(_ sender: UIButton) {
        delegate?.calendar_view_append_unnote()
    }
    
    @IBOutlet weak var note_list_button: UIButton!
    @IBAction func note_list_action(_ sender: UIButton) {
        delegate?.calendar_view_open_note_list()
    }
    
}
