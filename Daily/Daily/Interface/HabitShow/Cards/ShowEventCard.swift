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
    
    /**  */
    override func reload() {
        event_table.rowHeight = UITableViewAutomaticDimension
        event_table.reloadData()
        let height = max(event_table.contentSize.height + 74, 118)
        if frame.height != height {
            self.frame.size.height = height
        }
        table.update_content_size()
    }
    
    // MARK: - Tap
    
    override func tap_gesture(_ sender: UITapGestureRecognizer) {
        show.performSegue(
            withIdentifier: "EventList",
            sender: obj
        )
    }
    
    // MARK: - Empty
    
    /**  */
    @IBOutlet weak var empty: UIButton!
    
    /**  */
    @IBAction func empty_action(_ sender: UIButton) {
        show.performSegue(
            withIdentifier: "EventList",
            sender: obj
        )
    }
    
    // MARK: - Table
    
    /**  */
    @IBOutlet weak var event_table: UITableView!
    
    /**  */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        empty.isHidden = (obj.cache.events.count != 0)
        return obj.cache.events.count
    }
    
    /**  */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShowEventCell
        cell.view_update(index: indexPath, view: self)
        return cell
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
        state.isSelected = !obj.is_complete
    }
    
    // MARK: - Event
    
    /**  */
    @IBOutlet weak var event: UILabel!
    
    /**  */
    @IBOutlet weak var note: UILabel!
    
    // MARK: - Reload
    
    /** Event Object */
    var obj: Habit.Event {
        return (view as! ShowEventCard).obj.cache.events[index.row]
    }
    
    /**  */
    override func view_reload() {
        event.text = obj.name
        note.text = obj.note
        state.isSelected = !obj.is_complete
    }
    
}
