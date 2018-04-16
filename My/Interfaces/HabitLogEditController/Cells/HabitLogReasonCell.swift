//
//  HabitLogReasonCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogReasonCell: HabitLogNoteCell {
    
    override func inputview(_ view: InputView, save_action text: String) {
        super.inputview(view, save_action: text)
        log.control?.save.isEnabled = !text.isEmpty
    }
    
}
