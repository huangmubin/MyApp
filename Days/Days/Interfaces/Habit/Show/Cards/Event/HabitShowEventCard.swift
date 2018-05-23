//
//  HabitShowEventCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowEventCard: DaysCardView, UITableViewDataSource, UITableViewDelegate, KeyboardInputDelegate {

    // MARK: - Date
    
    var events: [Event] = []
    
    // MARK: - Reload
    
    override func reload() {
        events = Event.find(habit: habit)
        reload_table()
    }
    
    /** 重新加载数据 */
    func reload_table() {
        let height = max(reload_heights(), 40) + 120
        table_view.reloadData()
        table_view.sizeToFit()
        if self.frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = height
                self.table.update_content_size()
            })
        }
    }
    
    // MARK: - Open
    
    /**  */
    @IBAction func open_list_action(_ sender: UIButton) {
    }
    
    /**  */
    @IBAction func append_event_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.title.text = "新增事件"
            view.push()
        }
    }
    
    /**  */
    func keyboard_input(input: KeyboardInput, save value: String) {
        let event = Event()
        event.value.habit = habit.value.id
        event.value.name = value
        event.value.detail = "测试详细内容的添加: \(value)"
        event.value.id = SQLite.Event.new_id
        event.value.list = (events.last?.value.list ?? 0) + 1
        event.value.insert()        
        events.append(event)
        reload_table()
    }
    
    // MARK: - Table View
    
    @IBOutlet weak var table_view: UITableView! {
        didSet {
            table_view.register(UINib(nibName: "HabitShowEventCardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitShowEventCardCell
        let event = events[indexPath.row]
        cell.name_label.text = event.value.name
        cell.detail_label.text = event.value.detail
        cell.state_button.isSelected = event.value.is_complete
        cell.view_update(index: indexPath, view: self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = events.remove(at: indexPath.row)
            let height = heights.remove(at: indexPath.row)
            event.value.delete()
            tableView.deleteRows(at: [indexPath], with: .fade)
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height -= height
                self.layoutIfNeeded()
                self.table.update_content_size()
            })
        }
    }
    
    // MARK: - height
    
    var heights: [CGFloat] = []
    
    @IBOutlet weak var height_name_label: UILabel!
    @IBOutlet weak var height_detail_label: UILabel!
    
    func reload_heights() -> CGFloat {
        heights.removeAll(keepingCapacity: true)
        var total: CGFloat = 0
        let size = CGSize(width: UIScreen.main.bounds.width - 100, height: 5000)
        for event in events {
            height_name_label.text = event.value.name
            height_detail_label.text = event.value.detail
            let name = height_name_label.sizeThatFits(size).height
            let detail = height_detail_label.sizeThatFits(size).height
            total = total + name + detail + 16
            heights.append(name + detail + 16)
        }
        print("heights = \(heights)")
        return total
    }
    
}

class HabitShowEventCardCell: TableViewCell {
    
    var event: Event { return (view as! HabitShowEventCard).events[index.row] }
    
    @IBOutlet weak var state_button: UIButton!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var detail_label: UILabel!
    
    @IBAction func state_action(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        event.value.is_complete = sender.isSelected
        event.value.update()
    }
    
}
