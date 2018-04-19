//
//  iDateSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class iDateSelector: View, i_SelectorDelegate {
    
    func update(date: Date) {
        year?.scroll(data: date.year.description, animate: true)
        month?.scroll(data: date.month.description, animate: true)
    }
    
    func date(day: Int = 1, hour: Int = 0, minute: Int = 0) -> Date {
        let format = DateFormatter()
        format.dateFormat = "yyyy-M-d H:m"
        return format.date(from: "\(year.int)-\(month.int)-\(day) \(hour):\(minute)")!
    }
    
    // MARK: - Year
    
    @IBOutlet weak var year: iSelector!
    
    // MARK: - Month
    
    @IBOutlet weak var month: iSelector!
    
    // MARK: - i_SelectorDelegate
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        if iSel === year {
            
        } else {
            
        }
    }

}
