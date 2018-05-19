//
//  LogListCell.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogListCell: TableViewCell {

    static let format: DateFormatter = DateFormatter("a hh:mm")
    var format: DateFormatter { return LogListCell.format }
    
    // MARK: - Value
    
    var date: Int = 0
    
    var habit: Habit {
        return (controller as! LogListController).habit
    }
    
    var log: Log {
        return (controller as! LogListController).habit.logs(date: date)[index.row]
    }
    
    // MARK: - Time
    
    @IBOutlet weak var length_label: UILabel!
    
    @IBOutlet weak var time_label: UILabel!
    
    @IBOutlet weak var note_label: UILabel!
    
    // MARK: - Back
    
    @IBOutlet weak var back_height_layout: NSLayoutConstraint!
    @IBOutlet weak var back_center_layout: NSLayoutConstraint!
    
    
    // MARK: - Reload
    
    override func view_reload() {
        let log = self.log
        if log.is_time {
            length_label.text = log.length_text
        } else {
            length_label.text = "\(log.value.length) 次"
        }
        
        if length_label.text == "0分钟" {
            print("Error")
        }
        
        time_label.text = format.string(from: log.value.date_s)
        
        note_label.text = log.value.note
        
        let logs = habit.logs(date: date)
        if logs.count <= 1 {
            back_center_layout.constant = 0
            back_height_layout.constant = 0
        } else if index.row == 0 {
            back_center_layout.constant = 10
            back_height_layout.constant = 20
        } else if index.row == habit.logs(date: date).count - 1 {
            back_center_layout.constant = -10
            back_height_layout.constant = 20
        } else {
            back_center_layout.constant = 0
            back_height_layout.constant = 20
        }
    }
    
}
