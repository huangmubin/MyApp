//
//  Habit_Database.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/21.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit
import SQLite3

// MARK: - Table Name

extension Habit {
    static let table = "Habit"
    var table: String { return Habit.table }
}

// MARK: - Create

extension Habit {
    
    /** 创建 数据表 */
    @discardableResult
    static func table_create() -> Bool {
        let sql = """
            create table if not exists \(table) (
                id integer primary key autoincrement,
                name text,
                _timeunit integer,
                priority integer,
                count integer,
                duration integer,
                _type integer,
                log_counts integer,
                log_duration integer,
                flag integer
            );
        """
        return sqlite.execut(sql: sql)
    }
    
}

// MARK: - Find

extension Habit {
    
    /** 查找数据 */
    static func table_find() -> [Habit] {
        let sql = "select * from \(table) where _type = 0;"
        var habits = [Habit]()
        sqlite.find(sql: sql, line: { Habit() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "name":
                obj.name = String(cString: sqlite3_column_text(state, i))
            case "_timeunit":
                obj.timeunit = TimeUnit(value: Int(sqlite3_column_int64(state, i)))
            case "priority":
                obj.priority = Int(sqlite3_column_int64(state, i))
            case "count":
                obj.count = Int(sqlite3_column_int64(state, i))
            case "duration":
                obj.duration = Int(sqlite3_column_int64(state, i))
            case "_type":
                obj.type = HabitType(value: Int(sqlite3_column_int64(state, i)))
            case "log_counts":
                obj.log_counts = Int(sqlite3_column_int64(state, i))
            case "log_duration":
                obj.log_duration = Int(sqlite3_column_int64(state, i))
            case "flag":
                obj.flag = Int(sqlite3_column_int64(state, i))
            default: break
            }
        }, next: { (obj) in
            habits.append(obj)
        })
        return habits
    }
    
    /** 查找数据 */
    static func table_find_idle() -> [Habit] {
        let sql = "select * from \(table) where _type = 1;"
        var habits = [Habit]()
        sqlite.find(sql: sql, line: { Habit() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "name":
                obj.name = String(cString: sqlite3_column_text(state, i))
            case "_timeunit":
                obj.timeunit = TimeUnit(value: Int(sqlite3_column_int64(state, i)))
            case "priority":
                obj.priority = Int(sqlite3_column_int64(state, i))
            case "count":
                obj.count = Int(sqlite3_column_int64(state, i))
            case "duration":
                obj.duration = Int(sqlite3_column_int64(state, i))
            case "_type":
                obj.type = HabitType(value: Int(sqlite3_column_int64(state, i)))
            case "log_counts":
                obj.log_counts = Int(sqlite3_column_int64(state, i))
            case "log_duration":
                obj.log_duration = Int(sqlite3_column_int64(state, i))
            case "flag":
                obj.flag = Int(sqlite3_column_int64(state, i))
            default: break
            }
        }, next: { (obj) in
            habits.append(obj)
        })
        return habits
    }
    
    /** 查看是否存在 */
    func table_exist() -> Bool {
        let sql = "select id from \(table);"
        return sqlite.find(sql: sql).count > 0
    }
    
}

// MARK: - Insert

extension Habit {
    
    /** 插入数据 */
    func table_insert() -> Bool {
        let sql = "insert into \(table) (name, _timeunit, priority, count, duration, _type, log_counts, log_duration, flag) values(?,?,?,?,?,?,?,?,?);"
        return sqlite.insert(
            sql: sql,
            datas: { (state) in
                sqlite3_bind_text(state, 1, name.cString(using: .utf8)!.map({$0}), -1, nil)
                sqlite3_bind_int64(state, 2, Int64(timeunit.rawValue))
                sqlite3_bind_int64(state, 3, Int64(priority))
                sqlite3_bind_int64(state, 4, Int64(count))
                sqlite3_bind_int64(state, 5, Int64(duration))
                sqlite3_bind_int64(state, 6, Int64(type.rawValue))
                sqlite3_bind_int64(state, 7, Int64(log_counts))
                sqlite3_bind_int64(state, 8, Int64(log_duration))
                sqlite3_bind_int64(state, 9, Int64(flag))
        })
    }
    
}

// MARK: - Update

extension Habit {
    
    /** 更新数据到数据库 */
    func table_update() -> Bool {
        let sql = "update \(table) set name = '\(name)', _timeunit = \(timeunit.rawValue), priority = \(priority), count = \(count), duration = \(duration), _type = \(type.rawValue), log_counts = \(log_counts), log_duration = \(log_duration), flag = \(flag) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新类型 */
    func table_update_type() -> Bool {
        let sql = "update \(table) set _type = \(type.rawValue) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新 log 次数与时长 */
    func table_update_log() -> Bool {
        let sql = "update \(table) set log_counts = \(log_counts), log_duration = \(log_duration) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新 flag */
    func table_update_flag() -> Bool {
        let sql = "update \(table) set flag = \(flag) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
}

// MARK: - Delete

extension Habit {
    
    /** 删除数据 */
    func table_delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return sqlite.execut(sql: sql)
    }
    
}

