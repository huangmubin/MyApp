//
//  HabitLog.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/22.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - HabitLogType

enum HabitLogType: Int {
    case present = 0
    case absence = 1
    init(value: Int?) {
        self = HabitLogType(rawValue: value ?? 0) ?? HabitLogType.present
    }
}

// MARK: - HabitLog

class HabitLog {

    // MARK: - Values
    
    /** 本身的 id */
    var id: Int = 0
    /** Habit 的 id */
    var habit: Int = 0
    /** 日期 */
    var date: Int = 0
    /** 开始时间 */
    var start: Int = 0
    /** 结束时间 */
    var end: Int = 0
    /** 记录 */
    var note: String = ""
    /** log type */
    private var _type: Int = 0
    /** log type */
    var type: HabitLogType {
        set { _type = newValue.rawValue }
        get { return HabitLogType(value: _type) }
    }
    
}

// MARK: - Infos

extension HabitLog {
    
    /** 持续时长 */
    var duration: Int { return end - start }
    
}

// MARK: - Tools

extension HabitLog {
    
    /** 根据信息快速初始化一条 Log，并且插入到数据库中 */
    convenience init(habit: Habit, type: HabitLogType = .present) {
        self.init()
        self.habit = habit.id
        self.date = Date().today
        self.start = habit.start()
        self.end = self.start + habit.duration
        self.type = type
        self.id = self.table_insert()
    }
    
    /** 根据信息快速初始化一条 Log，并且插入到数据库中 */
    convenience init(habit: Habit,  type: HabitLogType, date: Date) {
        self.init()
        self.habit = habit.id
        self.date = date.today
        self.start = Int(date.timeIntervalSince1970)
        self.end = self.start + habit.duration
        self.type = type
        self.id = self.table_insert()
    }
    
}
