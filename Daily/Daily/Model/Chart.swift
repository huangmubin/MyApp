//
//  Chart.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit
import SQLite3

extension Habit {
    class Chart {
        
        // MARK: - Init
        
        init(_ habit: Habit) {
            self.obj = habit
        }
        
        // MARK: - Interface
        
        weak var obj: Habit!
        
        var units: [Int] = []
        
        // MARK: - Database
        
        /** Id */
        var id: Int = 0
        /** 名称 */
        var name: String = ""
        /** 目标 */
        var goal: Int = 3600000
        /** 所属 habit 的 id */
        var habit: Int = 0
        /** 提示信息 */
        var note: String = ""
        
        // MARK: - Tools
        
        /** 获取最新的 id */
        static var new_id: Int {
            let id = UserDefaults.standard.integer(forKey: "Habit_Chart")
            UserDefaults.standard.set(id + 1, forKey: "Habit_Chart")
            return id + 1
        }
        
        // MARK: - SQLite
        
        /** Database table name */
        static let table = "Habit_Chart"
        /** Database table name */
        var table: String { return Chart.table }
        
        // MARK: Create
        
        /** 创建 数据表 */
        @discardableResult
        static func create() -> Bool {
            let sql = """
            create table if not exists \(table) (
            id integer primary key,
            name text,
            goal integer,
            habit integer,
            note text
            );
            """
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Find
        
        /** 根据完整的 SQL 语句查找数据 */
        private static func find(habit: Habit, sql: String) -> [Chart] {
            var charts = [Chart]()
            SQLite.default.find(sql: sql, line: { Chart(habit) }, datas: { (state, i, obj, name) in
                switch name {
                case "id":
                    obj.id = Int(sqlite3_column_int64(state, i))
                case "name":
                    obj.name = String(cString: sqlite3_column_text(state, i))
                case "goal":
                    obj.goal = Int(sqlite3_column_int64(state, i))
                case "habit":
                    obj.habit = Int(sqlite3_column_int64(state, i))
                case "note":
                    obj.note = String(cString: sqlite3_column_text(state, i))
                default: break
                }
            }, next: { charts.append($0) })
            return charts
        }
        
        /**
         where = nil 查找所有数据
         where != nil 则添加约束条件
         */
        static func find(habit: Habit, where value: String? = nil) -> [Chart] {
            var sql = "select * from \(table) where habit = \(habit.id)"
            if let v = value {
                sql += " and \(v);"
            } else {
                sql += ";"
            }
            return find(habit: habit, sql: sql)
        }
        
        // MARK: Insert
        
        /** 插入数据 */
        func insert() -> Bool {
            let sql = "insert into \(table) values(\(id), '\(name)', \(goal), \(habit), '\(note)');"
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Update
        
        /** 更新数据到数据库 */
        func update() -> Bool {
            let sql = "update \(table) set name = '\(name)', goal = \(goal), habit = \(habit), note = '\(note)' where id = \(id);"
            return SQLite.default.execut(sql: sql)
        }
        
        /** 更新数据到数据库 */
        func update(_ values: String) -> Bool {
            let sql = "update \(table) set \(values) where id = \(id);"
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Delete
        
        /** 删除数据 */
        func delete() -> Bool {
            let sql = "delete from \(table) where id = \(id);"
            return SQLite.default.execut(sql: sql)
        }
        
    }
}

