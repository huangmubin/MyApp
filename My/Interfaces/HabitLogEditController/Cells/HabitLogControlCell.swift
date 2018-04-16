//
//  HabitLogControlCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogControlCell: HabitLogCell {
    
    override func view_load() {
        log.control = self
        delete.isHidden = (log.log.id == 0)
        save.isEnabled  = (log.log.is_absent ? !(log.note?.note.text?.isEmpty ?? true) : true)
    }
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var save: UIButton!
    
    @IBAction func save_action() {
        log.tableView(cell: self, user: Keys.control.save)
    }
    @IBAction func delete_action() {
        log.tableView(cell: self, user: Keys.control.delete)
    }
    @IBAction func cancel_action() {
        log.tableView(cell: self, user: Keys.control.cancel)
    }
    
}
