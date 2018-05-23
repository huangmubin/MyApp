//
//  CardTextView.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CardTextView: DaysCardView, UITextViewDelegate {
    
    /** Text Value */
    public var value: String { return note?.text ?? "" }
    
    // MARK: - Label
    
    /** Title Label */
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Message
    
    /** TextView */
    @IBOutlet weak var note: UITextView!
    
    /** Size to append: textView.sizeThatFits(textView.bounds.size).height + space */
    @IBInspectable var space: CGFloat = 67
    
    public func textViewDidChange(_ textView: UITextView) {
        let height = textView.sizeThatFits(textView.bounds.size).height + space
        if frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = height
                self.table.update_content_size()
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Tap
    
    /** Tap Gesture action */
    override public func tap_gesture(_ sender: UITapGestureRecognizer) {
        if note.isFirstResponder {
            note.resignFirstResponder()
        } else {
            note.becomeFirstResponder()
        }
    }
    
    // MARK: - Scroll
    
    /** Scroll Action */
    override public func scroll_begin_dragging_action() {
        note.resignFirstResponder()
    }
    

}
