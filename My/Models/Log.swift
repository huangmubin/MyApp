//
//  Log.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation
import SQLite3

extension Habit {
    class Log {
        
        // MARK: - Habit
        
        /** 习惯 */
        weak var obj: Habit!
        init(_ obj: Habit) {
            self.obj = obj
            
            let now = Date()
            self.id         = new_id
            self.habit      = obj.id
            self.date       = now.today
            self.start_time = now.time1970 - obj.duration * 60
            self.end_time   = now.time1970
        }
        
        /** 新建待编辑条目 */
        init(create obj: Habit, absent: Bool) {
            self.obj = obj
            
            let now = Date()
            self.id = 0
            self.is_absent  = absent
            self.habit      = obj.id
            self.date       = now.today
            self.start_time = now.time1970 - obj.duration * 60
            self.end_time   = now.time1970
        }
        
        // MARK: - Database
        
        /** 本身的 id */
        var id: Int = 0
        /** Habit 的 id */
        var habit: Int = 0
        /** 日期 */
        var date: Int = 0
        /** 开始时间 */
        var start_time: Int = 0
        /** 结束时间 */
        var end_time: Int = 0
        /** 记录 */
        var note: String = ""
        /** log type */
        fileprivate var _type: Int = 0
        
        // MARK: - Interface
        
        /** log type */
        var is_absent: Bool {
            set { _type = newValue ? 1 : 0 }
            get { return _type == 1 }
        }
        
        /** Duration */
        var duration: Int { return end_time - start_time }
        
        /** 开始时间 */
        var start: Date {
            set { start_time = newValue.time1970 }
            get { return Date(timeIntervalSince1970: TimeInterval(start_time)) }
        }
        
        /** 结束时间 */
        var end: Date {
            set { end_time = newValue.time1970 }
            get { return Date(timeIntervalSince1970: TimeInterval(end_time)) }
        }
    }
}

// MARK: - Static

extension Habit.Log {
    
    /** 创建最新的 id */
    var new_id: Int {
        let id = UserDefaults.standard.integer(forKey: "Log_id")
        UserDefaults.standard.set(id + 1, forKey: "Log_id")
        return id + 1
    }
    
}

// MARK: - Database

extension Habit.Log {
    
    /** Database table name */
    static let table = "Habit_Log"
    /** Database table name */
    var table: String { return Habit.Log.table }
    
    // MARK: Create
    
    /** 创建 数据表 */
    @discardableResult
    static func table_create() -> Bool {
        let sql = """
        create table if not exists \(table) (
            id integer primary key,
            habit integer,
            date integer,
            start_time integer,
            end_time integer,
            note text,
            _type integer
        );
        """
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Insert
    
    /** 插入数据 */
    func table_insert() -> Bool {
        let sql = "insert into \(table) values(\(id), \(habit), \(date), \(start_time), \(end_time), '\(note)', \(_type));"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Delete
    
    /** 删除数据 */
    @discardableResult
    func table_delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Find
    
    /** 根据 SQL 跟 Habit 查找记录 */
    private static func table_find(habit: Habit, sql: String) -> [Habit.Log] {
        var logs = [Habit.Log]()
        SQLite.default.find(sql: sql, line: { Habit.Log(habit) }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "habit":
                obj.habit = Int(sqlite3_column_int64(state, i))
            case "date":
                obj.date = Int(sqlite3_column_int64(state, i))
            case "start_time":
                obj.start_time = Int(sqlite3_column_int64(state, i))
            case "end_time":
                obj.end_time = Int(sqlite3_column_int64(state, i))
            case "note":
                obj.note = String(cString: sqlite3_column_text(state, i))
            case "_type":
                obj._type = Int(sqlite3_column_int64(state, i))
            default: break
            }
        }, next: { logs.append($0) })
        return logs
    }
    
    /** 根据 Habit 查找数据 */
    static func table_find(habit: Habit) -> [Habit.Log] {
        return table_find(
            habit: habit,
            sql: "select * from \(table) where habit = \(habit.id);"
        )
    }
    
    /** 根据日期查找数据 */
    static func table_find(habit: Habit, date: Int) -> [Habit.Log] {
        return table_find(
            habit: habit,
            sql: "select * from \(table) where habit = \(habit.id) and date = \(date);"
        )
    }
    
    // MARK: Update
    
    /** 更新数据到数据库 */
    func table_update() -> Bool {
        let sql = "update \(table) set date = \(date), start = \(start_time), end = \(end_time), note = \(note), _type = \(_type) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    /** 更新 */
    func table_update_time() -> Bool {
        let sql = "update \(table) set date = \(date), start = \(start_time), end = \(end_time) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    /** 更新 */
    func table_update_note() -> Bool {
        let sql = "update \(table) set note = \(note) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    /** 更新 */
    func table_update_type() -> Bool {
        let sql = "update \(table) set _type = \(_type) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
}
