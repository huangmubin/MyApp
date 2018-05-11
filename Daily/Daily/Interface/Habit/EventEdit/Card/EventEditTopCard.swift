//
//  EventEditTopCard.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventEditTopCard: EventEditCard {

    
    // MARK: - Name
    
    /** Habit name */
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Actions
    
    @IBAction func error_action(_ sender: UIButton) {
        edit.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func success_action(_ sender: UIButton) {
        if let card = table.card(id: "Name") as? EventEditNameCard {
            obj.name = card.value
            card.note.resignFirstResponder()
        }
        if let card = table.card(id: "Note") as? EventEditNoteCard {
            obj.note = card.value
            card.note.resignFirstResponder()
        }
        if obj.id == 0 {
            obj.id = Habit.Event.new_id
            edit.toSuperController(object: ["EventAdd": obj])
        } else {
            edit.toSuperController(object: ["EventEdit": obj])
        }
        edit.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Reload
    
    override func reload() {
        name.text = obj.obj.name
    }
    
}
