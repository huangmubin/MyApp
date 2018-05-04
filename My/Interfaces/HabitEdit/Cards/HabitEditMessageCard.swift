//
//  HabitEditMessageCard.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditMessageCard: HabitEditCard, InputViewDelegate {

    override func reload() {
        inputView(InputTextView(delegate: self), save_action: edit.habit.message)
    }
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func push() {
        if let view = InputTextView.load(nib: nil) {
            view.delegate = self
            view.frame = edit.table.frame
            edit.view.addSubview(view)
        }
    }
    
    func inputView(_ view: InputView, save_action value: Any) {
        message.text = value as? String
        let h = max(message.sizeThatFits(CGSize(width: bounds.width, height: 42)).height, 42)
        self.frame.size.height = h + 48
        table.update_content_size()
    }

}
