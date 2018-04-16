//
//  HabitShow.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/27.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

/** Habit Controller 显示 Model */
class HabitShow {
    
    // MARK: - Values
    
    let habit: Habit
    init(habit: Habit) {
        self.habit = habit
    }
    
    /** Date : [Habitlog] */
    var calendar: [Int: [HabitLog]] = [:]
    
    // MARK: - Tools
    
    /** Cycle is absence */
    func is_absence(date: Date) -> Bool {
        return logs(date: date.today).contains(where: { $0.type == .absence })
    }
    
    /** Cycle is done */
    func is_done(date: Date) -> Bool {
        switch habit.timeunit {
        case .day:
            return logs(date: date.today).count >= habit.count
        case .week:
            var i = 0
            for day in week(date: date) {
                i += logs(date: day).count
            }
            return i >= habit.count
        case .month:
            var i = 0
            for day in month(date: date) {
                i += logs(date: day).count
            }
            return i >= habit.count
        }
    }
    
    // MARK: - Datebase
    
    /** Find the logs in date */
    func logs(date: Int) -> [HabitLog] {
        if let log = calendar[date] {
            return log
        } else {
            let log = HabitLog.table_find(habit: habit.id, date_s: date, date_e: date + 1)
            calendar[date] = log
            return log
        }
    }
    
    // MARK: - Date
    
    private static let format: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format
    }()
    func date(_ v: Int) -> Date {
        return HabitShow.format.date(from: v.description)!
    }
    
    /** Date Range */
    func week(date: Date) -> [Int] {
        let s = date.first_day_in_week()!
        var days = [s.today]
        for i in 1 ..< 7 {
            days.append(s.advance(time: 86400 * Double(i)).today)
        }
        return days
    }
    
    /** Date Range */
    func month(date: Date) -> [Int] {
        let s = date.first_day_in_month()!
        var days = [s.today]
        for i in 1 ..< date.days_in_month {
            days.append(s.advance(time: 86400 * Double(i)).today)
        }
        return days
    }
}
