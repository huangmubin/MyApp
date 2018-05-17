//
//  HabitEditMessageCard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// 160 - 43 = 117
class HabitEditMessageCard: CardView, KeyboardInputDelegate {

    // MARK: - Reload
    
    override func reload() {
        message.text = habit.value.message
        let height = max(message.sizeThatFits(message.bounds.size).height + 117, 160)
        if self.frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = height
                self.table.update_content_size()
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Message
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func input_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.title.text = "告诉自己"
            view.push()
        }
    }
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        habit.value.message = value
        reload()
    }
    
}
