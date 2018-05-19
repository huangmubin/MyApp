//
//  LogListHeader.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogListHeader: TableViewHeaderFooter {

    // MARK: - Format
    
    static let format: DateFormatter = DateFormatter("yyyy 年 M 月 d 日")
    var format: DateFormatter { return LogListHeader.format }
    
    // MARK: - data
    
    var habit: Habit {
        return (controller as! LogListController).habit
    }
    var date: Int = 0
    
    // MARK: - date
    
    @IBOutlet weak var date_label: UILabel!
    
    // MARK: - Reload
    
    override func view_reload() {
        date_label.text = format.string(from: Log.date(at: date))
        if let state = habit.status(at_date: date) {
            if state >= 1 {
                date_label.text = "\(date_label.text!) - 达成"
            }
        } else {
            date_label.text = "\(date_label.text!) - 请假"
        }
    }

}
