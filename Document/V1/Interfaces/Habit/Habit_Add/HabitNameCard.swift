//
//  HabitNameCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitNameCard: Card, UITextViewDelegate {

    @IBOutlet weak var text_view: UITextView!
    
    func textViewDidChange(_ textView: UITextView) {
        self.right_button.isEnabled = !text_view.text.isEmpty
    }
    
}
