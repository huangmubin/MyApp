//
//  Event.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation
import SQLite3

extension Habit {
    
    /** 事件模型 */
    class Event {
        
        // MARK: - Model
        
        weak var obj: Habit!
        init(_ obj: Habit) {
            self.obj = obj
            
            let now = Date()
            self.habit  = obj.id
            self.start  = now.date
            self.end    = now.advance(.day, 10).date
        }
        
        // MARK: - Interface
        
        /** 是否是请假 */
        var is_complete: Bool {
            get { return type == 1 }
            set { type = newValue ? 1 : 0 }
        }
        
        // MARK: - Database
        
        /** 本身的 id */
        var id: Int = 0
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 名称 */
        var name: String = ""
        
        /** 开始的日期 20180610 */
        var start: Int = 0
        /** 结束的日期 20180610 */
        var end: Int = 0
        /** 文本记录 */
        var note: String = ""
        /** 类型记录，未完成 0, 完成 1 */
        var type: Int = 0
        
        /** 等级 0 为最高级 */
        var level: Int = 0
        /** 排列顺序, 0 为最先 */
        var sort: Int = 0
        
        // MARK: - Tools
        
        /** 创建最新的 id */
        static var new_id: Int {
            let id = UserDefaults.standard.integer(forKey: "Event_id")
            UserDefaults.standard.set(id + 1, forKey: "Event_id")
            return id + 1
        }
        
        // MARK: - SQLite
        
        /** Database table name */
        static let table = "Habit_Event"
        /** Database table name */
        var table: String { return Habit.Event.table }
        
        // MARK: Create
        
        /** 创建 数据表 */
        @discardableResult
        static func create() -> Bool {
            let sql = """
            create table if not exists \(table) (
            id integer primary key,
            habit integer,
            name text,
            start integer,
            end integer,
            note text,
            type integer,
            level integer,
            sort integer
            );
            """
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Insert
        
        /** 插入数据 */
        func insert() -> Bool {
            let sql = "insert into \(table) values(\(id), \(habit), '\(name)', \(start), \(end), '\(note)', \(type), \(level), \(sort));"
            return SQLite.default.execut(sql: sql)
        }
        
        // MARK: Find
        
        /** 根据 SQL 跟 Habit 查找记录 */
        private static func find(habit: Habit, sql: String) -> [Event] {
            var events = [Event]()
            SQLite.default.find(sql: sql, line: { Event(habit) }, datas: { (state, i, obj, name) in
                switch name {
                case "id":
                    obj.id = Int(sqlite3_column_int64(state, i))
                case "habit":
                    obj.habit = Int(sqlite3_column_int64(state, i))
                case "name":
                    obj.name = String(cString: sqlite3_column_text(state, i))
                case "start":
                    obj.start = Int(sqlite3_column_int64(state, i))
                case "end":
                    obj.end = Int(sqlite3_column_int64(state, i))
                case "note":
                    obj.note = String(cString: sqlite3_column_text(state, i))
                case "type":
                    obj.type = Int(sqlite3_column_int64(state, i))
                case "level":
                    obj.level = Int(sqlite3_column_int64(state, i))
                case "sort":
                    obj.sort = Int(sqlite3_column_int64(state, i))
                default: break
                }
            }, next: { events.append($0) })
            return events
        }
        
        /** 根据条件查找数据 */
        static func find(habit: Habit, where value: String? = nil) -> [Event] {
            var sql = "select * from \(table)"
            if let v = value {
                sql += " where \(v);"
            } else {
                sql += ";"
            }
            return find(habit: habit, sql: sql)
        }
        
        // MARK: Update
        
        /** 更新数据到数据库 */
        func update() -> Bool {
            let sql = "update \(table) set name = \(name), start = \(start), end = \(end), note = \(note), type = \(type), level = \(level), sort = \(sort) where id = \(id)"
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
