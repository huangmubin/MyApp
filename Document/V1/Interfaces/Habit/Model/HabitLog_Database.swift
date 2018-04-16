//
//  HabitLog_Database.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/22.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit
import SQLite3

// MARK: - Table Name

extension HabitLog {
    static let table = "HabitLog"
    var table: String { return HabitLog.table }
}

// MARK: - Create

extension HabitLog {
    
    /** 创建 数据表 */
    @discardableResult
    static func table_create() -> Bool {
        let sql = """
        create table if not exists \(table) (
            id integer primary key autoincrement,
            habit integer,
            date integer,
            start integer,
            end integer,
            note text,
            _type integer
        );
        """
        return sqlite.execut(sql: sql)
    }
    
}

// MARK: - Find

extension HabitLog {
    
    /** 根据前后时间查找数据 */
    static func table_find(habit: Int, start: Int = 0, end: Int = Int.max) -> [HabitLog] {
        let sql = "select * from \(table) where habit = \(habit) and start > \(start) and end < \(end);"
        var logs = [HabitLog]()
        sqlite.find(sql: sql, line: { HabitLog() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "date":
                obj.date = Int(sqlite3_column_int64(state, i))
            case "start":
                obj.start = Int(sqlite3_column_int64(state, i))
            case "end":
                obj.end = Int(sqlite3_column_int64(state, i))
            case "note":
                obj.note = String(cString: sqlite3_column_text(state, i))
            case "_type":
                obj.type = HabitLogType(value: Int(sqlite3_column_int64(state, i)))
            default: break
            }
        }, next: { (obj) in
            logs.append(obj)
        })
        return logs
    }
    
    /** 根据日期查找数据 */
    static func table_find(habit: Int, date: Int) -> [HabitLog] {
        let sql = "select * from \(table) where habit = \(habit) and date = \(date);"
        var logs = [HabitLog]()
        sqlite.find(sql: sql, line: { HabitLog() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "date":
                obj.date = Int(sqlite3_column_int64(state, i))
            case "start":
                obj.start = Int(sqlite3_column_int64(state, i))
            case "end":
                obj.end = Int(sqlite3_column_int64(state, i))
            case "note":
                obj.note = String(cString: sqlite3_column_text(state, i))
            case "_type":
                obj.type = HabitLogType(value: Int(sqlite3_column_int64(state, i)))
            default: break
            }
        }, next: { (obj) in
            logs.append(obj)
        })
        return logs
    }
    
    /** 根据日期区间查找数据 s ..< e */
    static func table_find(habit: Int, date_s: Int, date_e: Int) -> [HabitLog] {
        let sql = "select * from \(table) where habit = \(habit) and date >= \(date_s) and date < \(date_e);"
        var logs = [HabitLog]()
        sqlite.find(sql: sql, line: { HabitLog() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "date":
                obj.date = Int(sqlite3_column_int64(state, i))
            case "start":
                obj.start = Int(sqlite3_column_int64(state, i))
            case "end":
                obj.end = Int(sqlite3_column_int64(state, i))
            case "note":
                obj.note = String(cString: sqlite3_column_text(state, i))
            case "_type":
                obj.type = HabitLogType(value: Int(sqlite3_column_int64(state, i)))
            default: break
            }
        }, next: { (obj) in
            logs.append(obj)
        })
        return logs
    }
    
    
}

// MARK: - Absence Data

extension HabitLog {
    
    /** 根据日期查找数据 */
    static func table_find_absence(habit: Int, date: Int) -> [HabitLog] {
        let sql = "select * from \(table) where habit = \(habit) and date = \(date) and _type = 1;"
        var logs = [HabitLog]()
        sqlite.find(sql: sql, line: { HabitLog() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "date":
                obj.date = Int(sqlite3_column_int64(state, i))
            case "start":
                obj.start = Int(sqlite3_column_int64(state, i))
            case "end":
                obj.end = Int(sqlite3_column_int64(state, i))
            case "note":
                obj.note = String(cString: sqlite3_column_text(state, i))
            case "_type":
                obj.type = HabitLogType(value: Int(sqlite3_column_int64(state, i)))
            default: break
            }
        }, next: { (obj) in
            logs.append(obj)
        })
        return logs
    }
    
}

// MARK: - Insert

extension HabitLog {
    
    /** 插入数据 */
    func table_insert() -> Int {
        let sql = "insert into \(table) (habit, date, start, end, note, _type) values(?,?,?,?,?,?);"
        if sqlite.insert(
            sql: sql,
            datas: { (state) in
                sqlite3_bind_int64(state, 1, Int64(habit))
                sqlite3_bind_int64(state, 2, Int64(date))
                sqlite3_bind_int64(state, 3, Int64(start))
                sqlite3_bind_int64(state, 4, Int64(end))
                sqlite3_bind_text(state, 5, note.cString(using: .utf8)!.map({$0}), -1, nil)
                sqlite3_bind_int64(state, 6, Int64(type.rawValue))
        }) {
            return sqlite.last_id()
        } else {
            return -1
        }
    }
    
}

// MARK: - Update

extension HabitLog {
    
    /** 更新数据到数据库 */
    func table_update() -> Bool {
        let sql = "update \(table) set date = \(date), start = \(start), end = \(end), note = \(note), _type = \(type.rawValue) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新记录 */
    func table_update_note() -> Bool {
        let sql = "update \(table) set note = \(note) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新时间 */
    func table_update_time() -> Bool {
        let sql = "update \(table) set date = \(date), start = \(start), end = \(end) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
    
    /** 更新类型 */
    func table_update_type() -> Bool {
        let sql = "update \(table) set _type = \(type.rawValue) where id = \(id)"
        return sqlite.execut(sql: sql)
    }
}

// MARK: - Delete

extension HabitLog {
    
    /** 删除数据 */
    @discardableResult
    func table_delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return sqlite.execut(sql: sql)
    }
    
}
