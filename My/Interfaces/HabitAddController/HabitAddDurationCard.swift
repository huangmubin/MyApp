//
//  HabitAddDurationCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitAddDurationCard: StepCard, i_SelectorDelegate {

    // MARK: - Data
    
    /** 时间 */
    var time: Int {
        return minute.int
    }
    
    // MARK: - Time
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minute: iSelector! {
        didSet {
            minute.data = iSelector.numbser(s: 1, e: 360)
            minute.reload()
        }
    }
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        label.text = "\(iSel.int) 分钟"
    }

}
