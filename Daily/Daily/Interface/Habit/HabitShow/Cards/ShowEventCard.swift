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
        update_heights()
        event_table.reloadData()
        let height = max(heights.count(value: {$0}) + 64, 118)
        print("height = \(height); size = \(event_table.contentSize.height); all = \(heights.count(value: {$0}))")
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
    
    // MARK: - Height
    
    @IBOutlet weak var height_name_label: UILabel!
    @IBOutlet weak var height_note_label: UILabel!
    
    var heights: [CGFloat] = []
    
    /** 更新高度 */
    func update_heights() {
        heights.removeAll()
        let name_size = CGSize(width: self.frame.width - 60, height: 500)
        let note_size = CGSize(width: self.frame.width - 60, height: 500)
        height_name_label.frame.size = name_size
        height_note_label.frame.size = note_size
        for event in obj.cache.events {
            height_name_label.text = event.name
            height_note_label.text = event.note
            heights.append(
                height_name_label.sizeThatFits(name_size).height + height_note_label.sizeThatFits(note_size).height + 8 + 2
            )
        }
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
    
    /**  */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show.performSegue(
            withIdentifier: "EventList",
            sender: obj
        )
    }
    
    /**  */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
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
        state.isSelected = obj.is_complete
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
        state.isSelected = obj.is_complete
    }
    
}
