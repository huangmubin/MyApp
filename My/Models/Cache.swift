//
//  Cache.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension Habit {
    class Cache: NSObject {
        
        // MARK: - Init
        
        /** 所属 Habit */
        weak var obj: Habit!
        init(habit: Habit) {
            self.obj = habit
        }
        
        /** 释放内存 */
        func clear() {
            data_logs.removeAll()
        }
        
        // MARK: - Date
        
        /** 日期列表 */
        fileprivate var dates: [Int] = []
        
        /** 更新日期列表 */
        func update_dates() {
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
        fileprivate var data_logs: [Int: [Habit.Log]] = [:]
        
        /** 根据日期获取记录 */
        func logs(_ date: Int) -> [Habit.Log] {
            if let v = data_logs[date] {
                return v
            } else {
                let v = Habit.Log.table_find(habit: obj, date: date)
                data_logs[date] = v
                return v
            }
        }
        
        /** 更新某一天的数据 */
        func update_logs(date: Int) {
            data_logs[date] = Habit.Log.table_find(habit: obj, date: date)
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

