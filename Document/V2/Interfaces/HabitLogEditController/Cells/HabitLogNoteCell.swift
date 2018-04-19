//
//  HabitLogNoteCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogNoteCell: HabitLogCell, InputView_Delegate {

    // MARK: - Layout
    
    @IBOutlet weak var height_layout: NSLayoutConstraint! {
        didSet {
            height_layout.constant = UIScreen.main.bounds.height - 496
        }
    }
    
    // MARK: - Deploy
    
    override func view_load() {
        log.note = self
    }
    
    override func view_reload() {
        note.text = log.log.note
    }
    
    // MARK: - View
    
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func action() {
        let input = InputView(delegate: self)
        input.text.text = note.text
        input.title.text = (self is HabitLogReasonCell ? "请假原因" : "留言")
        log.view.addSubview(input)
        input.text.becomeFirstResponder()
    }
    
    func inputview(_ view: InputView, save_action text: String) {
        note.text = text
        log.log.note = text
        log.table.reloadRows(at: [index], with: .automatic)
    }
    
}
