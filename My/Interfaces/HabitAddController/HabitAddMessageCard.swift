//
//  HabitAddMessageCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitAddMessageCard: StepCard {

    // MARK: - Name
    
    /** 获取当前名称 */
    var message: String {
        var message: String = text.text ?? ""
        while message.count > 0 && message.first == " " {
            message.removeFirst()
        }
        while message.count > 0 && message.last == " " {
            message.removeLast()
        }
        return message
    }
    
    // MARK: - TextView
    
    @IBOutlet weak var text: UITextView!
    
    // MARK: - Key Board
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override func view_deploy() {
        save.isEnabled = false
        observer(name: .UIKeyboardWillChangeFrame, selector: #selector(keyboard(_:)))
    }
    deinit { unobserver() }
    
    @objc func keyboard(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect_value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let rect = rect_value.cgRectValue
                UIView.animate(withDuration: 0.25, animations: {
                    self.bottom.constant = UIScreen.main.bounds.height - rect.minY + 20
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
}
