//
//  HabitDurationCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitDurationCard: Card, HorizontalSelector_Delegate_Protocol {
    
    // MARK: - Views
    
    @IBOutlet weak var hour: HorizontalSelector! {
        didSet {
            hour?.reload(datas: HorizontalSelector.hours)
        }
    }
    @IBOutlet weak var minute: HorizontalSelector! {
        didSet {
            minute?.reload(datas: HorizontalSelector.minutes)
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Functions
    
    /** 持续时间总计 */
    func duration() -> Int {
        return hour.index * 60 + minute.index
    }
    
    /** HorizontalSelector_Delegate_Protocol */
    func horizontalSelector(update selector: HorizontalSelector, index: Int) {
        label.text = "\(hour.index) hours and \(minute.index) minute"
    }
    
}
