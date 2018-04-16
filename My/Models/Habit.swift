//
//  Habit.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit
import SQLite3

class Habit {
    
    // MARK: - Database Value
    
    /** Habit 编码 Id */
    var id: Int = 0
    /** 名称 */
    var name: String = ""
    /** 优先级，0~10 default is 5 */
    var priority: Int = 5
    /** 每次持续时间 */
    var duration: Int = 0
    /** 类型，闲置，非闲置 */
    fileprivate var _type: Int = 0
    /** 功能标记 */
    fileprivate var _flag: String = "\(Keys.flags.info)-\(Keys.flags.calender)-\(Keys.flags.check)-\(Keys.flags.menu)"
    /** 目标留言 */
    var message: String = ""
    
    // MARK: - Interface Value
    
    /** 类型，闲置，非闲置 */
    var is_archive: Bool {
        set { _type = newValue ? 1 : 0 }
        get { return _type == 1 }
    }
    
    /** 获取设置功能列表 */
    var flags: [String] {
        set {
            _flag = ""
            for f in newValue { _flag = _flag + "\(f)-" }
            _flag.removeLast()
            let _ = table_update_flag()
        }
        get { return _flag.components(separatedBy: ["-"]) }
    }
    
    // MARK: - Sub Value
    
    var logs: Habit.Cache!
    
    var show: Habit.Show!
    
    /**  */
    func deploy_sub() {
        self.logs = Habit.Cache(habit: self)
        self.show = Habit.Show(habit: self)
    }
    
}

// MARK: - Static

extension Habit {
    
    /** 获取最新的 id */
    static var new_id: Int {
        let id = UserDefaults.standard.integer(forKey: "Habit_id")
        UserDefaults.standard.set(id + 1, forKey: "Habit_id")
        return id + 1
    }
    
    /** 全部 Logs 计数 */
    var total_counts: Int {
        return 0
    }
    
    /** 全部 Logs 计时 */
    var total_durations: Int {
        return 0
    }
    
}

// MARK: - Database

extension Habit {
    
    /** Database table name */
    static let table = "Habit"
    /** Database table name */
    var table: String { return Habit.table }
    
    // MAKR: Create
    
    /** 创建 数据表 */
    @discardableResult
    static func table_create() -> Bool {
        let sql = """
        create table if not exists \(table) (
            id integer primary key,
            name text,
            priority integer,
            duration integer,
            _type integer,
            _flag text,
            message text
        );
        """
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Find
    
    /** 根据类型查找所有数据
     所有数据 : nil
     进行数据 : 0
     归档数据 : 1
     */
    static func table_find(type: Int? = nil) -> [Habit] {
        let sql = "select * from \(table)\(type == nil ? ";" : "where _type = \(type!);")"
        
        var habits = [Habit]()
        SQLite.default.find(sql: sql, line: { Habit() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "name":
                obj.name = String(cString: sqlite3_column_text(state, i))
            case "priority":
                obj.priority = Int(sqlite3_column_int64(state, i))
            case "duration":
                obj.duration = Int(sqlite3_column_int64(state, i))
            case "_type":
                obj._type = Int(sqlite3_column_int64(state, i))
            case "_flag":
                obj._flag = String(cString: sqlite3_column_text(state, i))
            case "message":
                obj.message = String(cString: sqlite3_column_text(state, i))
            default: break
            }
        }, next: { habits.append($0) })
        return habits
    }
    
    // MARK: Insert
    
    /** 插入数据 */
    func table_insert() -> Bool {
        let sql = "insert into \(table) values(\(id), '\(name)', \(priority), \(duration), \(_type), '\(_flag)', '\(message)');"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Update
    
    /** 更新数据到数据库 */
    func table_update() -> Bool {
        let sql = "update \(table) set name = '\(name)', priority = \(priority), duration = \(duration), _type = \(_type), flag = \(_flag), message = \(message) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    /** 更新 */
    func table_update_name() -> Bool {
        let sql = "update \(table) set name = \(name) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    /** 更新 */
    func table_update_priority() -> Bool {
        let sql = "update \(table) set priority = \(priority) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    /** 更新 */
    func table_update_duration() -> Bool {
        let sql = "update \(table) set duration = \(duration) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    /** 更新类型 */
    func table_update_type() -> Bool {
        let sql = "update \(table) set _type = \(_type) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    /** 更新 flag */
    func table_update_flag() -> Bool {
        let sql = "update \(table) set flag = '\(_flag)' where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    /** 更新 flag */
    func table_update_message() -> Bool {
        let sql = "update \(table) set message = '\(message)' where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Delete
    
    /** 删除数据 */
    func table_delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return SQLite.default.execut(sql: sql)
    }
}

