//
//  HabitListCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListCell: TableViewCell {
    
    // MARK: - Data
    
    /** Datas */
    weak var habit: Habit!
    
    // MARK: - Views
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var complete: UILabel!
    
    @IBOutlet weak var check: UIImageView!
    
    // MARK: - Reload
    
    /** Reload */
    override func view_reload() {
        name.text = habit.name
        start.text = "开始于 \(DateFormatter.Chinese.date.string(from: Date(time: habit.start)))"
        days.text = "打卡 \(habit.cache.dates.count) 天"
        if habit.is_time {
            count.text = String(format: "合计 %.1f 小时", Double(habit.cache.count / 360) / 10)
            goal.text = "目标 \(habit.goal / 3600) 小时"
        } else {
            count.text = "合计 \(habit.cache.count) 次"
            goal.text = "目标 \(habit.goal) 次"
        }
        complete.text = String(format: "已完成 %f%%", habit.cache.count * 100 / habit.goal)
        check.isHidden = !habit.cache.dates.contains(Date().date)
    }
    
}
