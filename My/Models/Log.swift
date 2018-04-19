//
//  Log.swift
//  My
//
//  Created by Myron on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation
import SQLite3

extension Habit {
    
    /** 记录模型 */
    class Log {
        
        // MARK: - Model
        
        weak var obj: Habit!
        init(_ obj: Habit) {
            self.obj = obj
            
            let now = Date()
            self.habit  = obj.id
            self.date   = now.date
            self.start  = now.time1970 - obj.length
            self.length = obj.length
        }
        
        // MARK: - Database
        
        /** 本身的 id */
        var id: Int = 0
        /** Habit 的 id */
        var habit: Int = 0
        /** 日期 */
        var date: Int = 0
        /** 开始时间，也是记录时间 */
        var start: Int = 0
        /** 时间长度，按秒算，或者次数，按次算 */
        var length: Int = 0
        /** 文本记录 */
        var note: String = ""
        /** 类型记录，正常打卡，请假打卡 */
        var type: Int = 0
        
        // MARK: - Tools
        
        /** 创建最新的 id */
        static var new_id: Int {
            let id = UserDefaults.standard.integer(forKey: "Log_id")
            UserDefaults.standard.set(id + 1, forKey: "Log_id")
            return id + 1
        }
        
        // MARK: - SQLite
        
        /** Database table name */
        static let table = "Habit_Log"
        /** Database table name */
        var table: String { return Habit.Log.table }
        
        // MARK: Create
        
        /** 创建 数据表 */
        @discardableResult
        static func create() -> Bool {
            let sql = """
            create table if not exists \(table) (
                id integer primary key,
                habit integer,
                date integer,
                start integer,
                length integer,
                note text,
                type integer
            );
            """
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Insert
        
        /** 插入数据 */
        func insert() -> Bool {
            let sql = "insert into \(table) values(\(id), \(habit), \(date), \(start), \(length), '\(note)', \(type));"
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Find
        
        /** 根据 SQL 跟 Habit 查找记录 */
        private static func find(habit: Habit, sql: String) -> [Log] {
            var logs = [Log]()
            SQLite.default.find(sql: sql, line: { Log(habit) }, datas: { (state, i, obj, name) in
                switch name {
                case "id":
                    obj.id = Int(sqlite3_column_int64(state, i))
                case "habit":
                    obj.habit = Int(sqlite3_column_int64(state, i))
                case "date":
                    obj.date = Int(sqlite3_column_int64(state, i))
                case "start":
                    obj.start = Int(sqlite3_column_int64(state, i))
                case "length":
                    obj.length = Int(sqlite3_column_int64(state, i))
                case "note":
                    obj.note = String(cString: sqlite3_column_text(state, i))
                case "type":
                    obj.type = Int(sqlite3_column_int64(state, i))
                default: break
                }
            }, next: { logs.append($0) })
            return logs
        }
        
        /** 根据条件查找数据 */
        static func find(habit: Habit, where value: String? = nil) -> [Log] {
            var sql = "select * from \(table)"
            if let v = value {
                sql += " \(v);"
            } else {
                sql += ";"
            }
            return find(habit: habit, sql: sql)
        }
        
        // MARK: Update
        
        /** 更新数据到数据库 */
        func update() -> Bool {
            let sql = "update \(table) set date = \(date), start = \(start), length = \(length), note = \(note), type = \(type) where id = \(id)"
            return SQLite.default.execut(sql: sql)
        }
        
        /** 更新数据到数据库 */
        func update(_ values: String) -> Bool {
            let sql = "update \(table) set \(values) where id = \(id)"
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Delete
        
        /** 删除数据 */
        @discardableResult
        func delete() -> Bool {
            let sql = "delete from \(table) where id = \(id);"
            return SQLite.default.execut(sql: sql)
        }
        
    }
    
}
