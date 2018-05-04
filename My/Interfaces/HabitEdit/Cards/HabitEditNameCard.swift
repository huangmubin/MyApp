//
//  HabitEditNameCard.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditNameCard: HabitEditCard, UITextViewDelegate {

    // MARK: - Reload
    
    /** Override: Reload */
    public override func reload() {
        text.text = edit.habit.name
    }

    // MARK: - Text
    
    /** Text */
    @IBOutlet weak var text: UITextView!
    
    /**  */
    func textViewDidChange(_ textView: UITextView) {
        let h = height()
        if h != self.frame.height {
            UIView.animate(withDuration: 0.25, animations: {
                self.text.contentOffset.y = 0
                self.frame.size.height = h
                self.table?.update_content_size()
            })
        }
    }
    
    // MARK: - Scroll
    
    /** Override: Scroll Action, Call when appear and scroll. */
    public override func scroll_action() {
        text?.resignFirstResponder()
    }
    
    // MARK: - Height
    
    /** Count the height of the view */
    func height() -> CGFloat {
        if text?.text.isEmpty == false {
            return text.sizeThatFits(text.bounds.size).height + 49
        } else {
            return 94
        }
    }
    
}
