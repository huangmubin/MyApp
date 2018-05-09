//
//  ShowEventCard.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Show Event Card

class ShowEventCard: HabitShowCard, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Reload
    
    override func reload() {
        let height = event_table.rowHeight * CGFloat(obj.cache.events.count) + 149
        if frame.height != height {
            self.frame.size.height = height
        }
        table.update_content_size()
    }
    
    // MARK: - Table
    
    @IBOutlet weak var event_table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj.cache.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShowEventCell
        cell.view_update(index: indexPath, view: self)
        return cell
    }
    
    // MARK: - Input
    
    @IBOutlet weak var input: UITextField!
    
    @IBAction func input_action() {
        if input.text?.isEmpty == false {
            let event = Habit.Event(obj)
            obj.cache.events.forEach({
                event.sort = max(event.sort, $0.sort)
            })
            event.sort += 1
            event.name = input.text!
            event.id = Habit.Event.new_id
            if event.insert() {
                obj.cache.events.append(event)
                reload()
                event_table.insertRows(at: [IndexPath(obj.cache.events)], with: UITableViewRowAnimation.automatic)
            }
        }
        input.text = ""
    }
    
    // MARK: - Scroll
    
    override func scroll_begin_dragging_action() {
        input.resignFirstResponder()
    }
    
}

// MARK: - Show Event Cell

class ShowEventCell: TableViewCell {
    
    // MARK: - State
    
    /**  */
    @IBOutlet weak var state: UIButton!
    
    /**  */
    @IBAction func state_action() {
        obj.is_complete = !obj.is_complete
        if !obj.update("type = \(obj.type)") {
            obj.is_complete = !obj.is_complete
        }
        state.isEnabled = !obj.is_complete
    }
    
    // MARK: - Event
    
    /**  */
    @IBOutlet weak var event: UILabel!
    
    // MARK: - Reload
    
    /** Event Object */
    var obj: Habit.Event {
        return (view as! ShowEventCard).obj.cache.events[index.row]
    }
    
    override func view_reload() {
        event.text = obj.name
        state.isEnabled = !obj.is_complete
    }
    
}
