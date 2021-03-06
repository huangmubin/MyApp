//
//  HabitEditMessageCard.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditMessageCard: HabitEditCard, UITextViewDelegate {

    
    /**  */
    var value: String {
        return note?.text ?? ""
    }
    
    // MARK: - Message
    
    /**  */
    @IBOutlet weak var note: UITextView!
    
    func textViewDidChange(_ textView: UITextView) {
        let height = textView.sizeThatFits(textView.bounds.size).height + 67
        if frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = height
                self.table.update_content_size()
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Reload
    
    /**  */
    override func reload() {
        note.text = habit.message
    }
    
    // MARK: - Tap
    
    /**  */
    override func tap_gesture(_ sender: UITapGestureRecognizer) {
        if note.isFirstResponder {
            note.resignFirstResponder()
        } else {
            note.becomeFirstResponder()
        }
    }
    
    // MARK: - Scroll
    
    /**  */
    override func scroll_begin_dragging_action() {
        note.resignFirstResponder()
    }
    

}
