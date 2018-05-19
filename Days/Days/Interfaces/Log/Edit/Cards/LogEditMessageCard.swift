//
//  LogEditMessageCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditMessageCard: CardView, KeyboardInputDelegate {

    // MARK: - Reload
    
    override func reload() {
        message.text = log.value.note
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
            view.title.text = "打卡留言"
            view.value = log.value.note
            view.push()
        }
    }
    
    func push_empty_error() {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.title.text = "打卡留言"
            view.value = log.value.note
            view.push()
            view.update_error(text: "请假打卡留言不能为空")
        }
    }
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        log.value.note = value
        reload()
    }

}
