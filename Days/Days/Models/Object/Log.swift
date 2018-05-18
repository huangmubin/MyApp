//
//  File.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

/** Log 数据 */
class Log {
    
    /** 数据 */
    let value: SQLite.Log
    /** Habit */
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Log, _ habit: Habit) {
        self.value = value
        self.habit = habit
    }
    
    init(_ habit: Habit) {
        self.habit = habit
        self.value = SQLite.Log()
        self.value.date = Date().date
        self.value.start = Date().time1970 - habit.value.length
        self.value.habit = habit.value.id
        self.value.length = habit.value.length
    }
    
    // MARK: - Find
    
    /** find log with habit and date */
    class func find(habit: Habit, date: Int) -> [Log] {
        return SQLite.Log.find(where: "habit = \(habit.value.id) and date = \(date)").map({ Log($0, habit) })
    }
    
    // MARK: - Length
    
    var length_text: String {
        let v = value.length / 60
        if v >= 60 {
            if v % 60 == 0 {
                return "\(v / 60)小时"
            } else {
                return "\(v / 60)小时\(v % 60)分钟"
            }
        } else {
            return "\(v % 60)分钟"
        }
    }
    
}
