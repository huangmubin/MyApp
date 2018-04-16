//
//  iTimeSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/6.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class iTimeSelector: View {
    
    func update(date: Date) {
        hour.scroll(i: date.hour, animate: true)
        minute.scroll(i: date.minute, animate: true)
    }
    
    func date(day: String?) -> Date {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyyMMdd-HH:mm"
        return format.date(from: "\(day ?? Date().today.description)-\(hour.int):\(minute.int)")!
    }
    
    @IBOutlet weak var hour: iSelector!
    @IBOutlet weak var minute: iSelector!
    
}
