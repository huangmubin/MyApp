//
//  HabitLogsCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/27.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogsCell: TableViewCell {

    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var duration_label: UILabel!
    @IBOutlet weak var note_label: UILabel!
    
    func update(log: HabitLog) {
        let format = DateFormatter()
        date_label.text = log.date.description
        
        format.dateFormat = "HH:mm"
        time_label.text = "\(format.string(from: Date(timeIntervalSince1970: TimeInterval(log.start)))) - \(format.string(from: Date(timeIntervalSince1970: TimeInterval(log.end))))"
        
        duration_label.text = "\(log.duration.time)"
        
        note_label.text = log.note.isEmpty ? "" : "\n\(log.note)"
    }
    
}
