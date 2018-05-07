//
//  Cache.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation
import SQLite3

extension Habit {
    
    /** 缓存 */
    class Cache {
        
        // MARK: - Init
        
        /** 所属 habit */
        weak var obj: Habit!
        init(habit: Habit) {
            self.obj = habit
            self.reload_count()
            self.reload_dates()
        }
        
        // MARK: - Clear
        
        /** 释放内存 */
        func clear() {
            _logs.removeAll(keepingCapacity: false)
        }
        
        // MARK: - Total
        
        /** 统计总打卡的时长 / 次数 */
        private var _count: Int = 0
        
        /** 统计总打卡的时长 / 次数 */
        var count: Int { return _count }
        
        /** 重新查询 */
        func reload_count() {
            _count = 0
            SQLite.default.find(
                sql: "select length from \(Habit.Log.table) where habit = \(obj.id);",
                default: 0,
                datas: { _count += $0 }
            )
        }
        
        // MARK: - Date
        
        /** 日期列表 */
        var dates: [Int] = []
        
        /** 更新日期列表 */
        func reload_dates() {
            dates.removeAll(keepingCapacity: true)
            SQLite.default.find(
                sql: "select distinct date from \(Habit.Log.table) where habit = \(obj.id);",
                default: 0,
                datas: { dates.append($0) }
            )
        }
        
        /** 根据下标获取数据 */
        func date(index: IndexPath) -> Int {
            return dates[index.section]
        }
        
        // MARK: - Logs
        
        /** Logs */
        private var _logs: [Int: [Habit.Log]] = [:]
        
        /** 根据日期获取记录 */
        func logs(_ date: Int) -> [Habit.Log] {
            if let v = _logs[date] {
                return v
            } else {
                let v = Habit.Log.find(habit: obj, where: "date = \(date)")
                _logs[date] = v
                return v
            }
        }
        
        /** 更新某一天的数据 */
        func reload_logs(date: Int) {
            _logs[date] = Habit.Log.find(habit: obj, where: "date = \(date)")
            if !dates.contains(date) {
                dates.append(date)
                dates.sort()
            }
        }
        
        /** 根据下标获取数据 */
        func logs(index: IndexPath) -> [Habit.Log] {
            return logs(dates[index.section])
        }
        
        /** 根据下标获取数据 */
        func log(index: IndexPath) -> Habit.Log {
            return logs(dates[index.section])[index.row]
        }
        
    }
    
}
