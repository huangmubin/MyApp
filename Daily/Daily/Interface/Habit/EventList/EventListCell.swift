//
//  EventListCell.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventListCell: TableViewCell {

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
        return (controller as! EventListController).habit.cache.events[index.row]
    }
    
    /**  */
    override func view_reload() {
        event.text = obj.name
        note.text = obj.note
        state.isSelected = obj.is_complete
        
    }
    
    override func view_load() {
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe_action(_:)))
        addGestureRecognizer(swipe)    
    }
    
    // MARK: - Gesture
    
    var swipe: UISwipeGestureRecognizer!
    
    @objc func swipe_action(_ sender: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .left:
            print("Swipe left at \(index.row)")
        case .right:
            print("Swipe right at \(index.row)")
        default: break
        }
    }
    

}
