//
//  LogEditDateCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditDateCard: CardDateView {

    override func reload() {
        value = log.value.date_s
        super.reload()
        if log.value.id == 0 {
            date_button.setTitleColor(Color.dark, for: .normal)
            date_button.isEnabled = true
            change_button.isEnabled = true
        } else {
            date_button.setTitleColor(Color.gray_dark, for: .normal)
            date_button.isEnabled = false
            change_button.isEnabled = false
        }
        //print("LogEditDateCard reload - \(value)")
    }
    
    override func update_date() {
        //print("update_date = \(value) - \(value.time1970); \(log.value.date_s) - \(log.value.start)")
        log.value.date = value.date
        log.value.start = value.first(.day).time1970 + log.value.date_s.time
        //print("end_date = \(value) - \(value.time1970); \(log.value.date_s) - \(log.value.start)")
    }

}
