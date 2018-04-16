//
//  HabitAddNameCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitAddNameCard: StepCard, UITextViewDelegate {

    // MARK: - Name
    
    /** 获取当前名称 */
    var name: String {
        var name: String = text.text ?? ""
        while name.count > 0 && name.first == " " {
            name.removeFirst()
        }
        while name.count > 0 && name.last == " " {
            name.removeLast()
        }
        return name
    }
    
    // MARK: - TextView
    
    @IBOutlet weak var text: UITextView! {
        didSet {
            text.delegate = self
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
         save.isEnabled = !name.isEmpty
    }
    

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
