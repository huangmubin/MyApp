//
//  Habit.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Habit Type

enum HabitType: Int {
    case normal = 0
    case idle = 1
    
    init(value: Int?) {
        self = HabitType(rawValue: value ?? 0) ?? .normal
    }
}

// MARK: - Object

class Habit {
    
    // MARK: - Values
    
    /** Habit 编码 Id */
    var id: Int = 0
    /** 名称 */
    var name: String = ""
    
    /** 时间单位 */
    private var _timeunit: Int = 0
    /** 时间单位 */
    var timeunit: TimeUnit {
        set { _timeunit = newValue.rawValue }
        get { return TimeUnit(value: _timeunit) }
    }
    
    /** 优先级，0~10 default is 5 */
    var priority: Int = 5
    
    /** 每个周期重复次数 */
    var count: Int = 0
    /** 每次持续时间 */
    var duration: Int = 0
    
    /** 类型，闲置，非闲置 */
    private var _type: Int = 0
    /** 类型，闲置，非闲置 */
    var type: HabitType {
        set { _type = newValue.rawValue }
        get { return HabitType(value: _type) }
    }
    
    /** 总打卡次数 */
    var log_counts: Int = 0
    /** 总打卡时长 */
    var log_duration: Int = 0
    
    /** 功能标记 */
    var flag: Int = 0
    
    // MARK: - Temp Values
    
    /** 周期日期开始 */
    var cycle_s: Int = 0
    /** 周期日期结束 */
    var cycle_e: Int = 0
    /** 本周期是否已经完成 */
    var cycle_done: Bool { return cycle_logs >= count }
    /** 周期内的记录数量 */
    var cycle_logs: Int = 0
    
}

// MARK: - New Info

extension Habit {
    
    /** 输出简介信息 */
    func infos() -> String {
        return "Every \(timeunit) need \(count) duration \(duration)"
    }
    
    /** 输出频率信息 */
    func frequency() -> String {
        return "Evey \(timeunit) \(count) times"
    }
    
    /** 输出持续时长 */
    func total_duration() -> String {
        return ""
    }
    
}

// MARK: - Keys

extension Habit {
    
    /** 用于新建的 Key */
    static let new: String = "Habit_new"
    
    /** 用于编辑的 Key */
    static let edit: String = "Habit_edit"
    
    /** 用于删除的 Key */
    static let delete: String = "Habit_delete"
    
}

// MARK: - Time Tools

extension Habit {
    
    /** Get the start time from current */
    func start() -> Int {
        return Int(Date().timeIntervalSince1970) - duration
    }
    
}

// MARK: - Cycle Tools

extension Habit {
    
    /** update cycle start and end */
    func cycle(date: Date) {
        switch timeunit {
        case .day:
            cycle_s = date.today
            cycle_e = cycle_s + 1
        case .week:
            cycle_s = date.first_day_in_week()!.today
            cycle_e = date.first_day_in_week()!.advance(time: 86400 * 7).today
        case .month:
            cycle_s = date.first_day_in_month()!.today
            cycle_e = date.first_day_in_month()!.advance(time: 86400 * Double(date.days_in_month)).today
        }
    }
    
    /** update cycle logs */
    func cycle_logs_update() {
        cycle_logs = HabitLog.table_find(habit: id, date_s: cycle_s, date_e: cycle_e).count
    }
    
}

/*
// MARK: - New Id

extension Habit {
    /** 创建最新的 id */
    class func id_now() -> Int {
        let id = UserDefaults.standard.integer(forKey: "Habit_id")
        UserDefaults.standard.set(id + 1, forKey: "Habit_id")
        return id + 1
    }
}
 */

