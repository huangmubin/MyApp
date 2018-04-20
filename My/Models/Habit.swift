//
//  Habit.swift
//  My
//
//  Created by Myron on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation
import SQLite3

/** 习惯数据 */
class Habit {
    
    // MARK: - Database
    
    /** Habit 编码 Id */
    var id: Int = 0
    /** 名称 */
    var name: String = ""
    /** 时间，次数 */
    var type: Int = 0
    /** 默认长度，时间长度xx秒，次数的长度默认是 1 */
    var length: Int = 1
    /** 功能标记，\n 换行符为一个标记 */
    var flag: String = """
    \(Keys.flags.info)
    \(Keys.flags.calender)
    \(Keys.flags.check)
    \(Keys.flags.menu)
    """
    /** 目标留言 */
    var message: String = ""
    
    // MARK: - Tools
    
    /** 获取最新的 id */
    static var new_id: Int {
        let id = UserDefaults.standard.integer(forKey: "Habit_id")
        UserDefaults.standard.set(id + 1, forKey: "Habit_id")
        return id + 1
    }
    
    // MARK: - SQLite
    
    /** Database table name */
    static let table = "Habit"
    /** Database table name */
    var table: String { return Habit.table }
    
    // MARK: Create
    
    /** 创建 数据表 */
    @discardableResult
    static func create() -> Bool {
        let sql = """
        create table if not exists \(table) (
        id integer primary key,
        name text,
        type integer,
        length integer,
        flag text,
        message text
        );
        """
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Find
    
    /** 根据完整的 SQL 语句查找数据 */
    private static func find(sql: String) -> [Habit] {
        var habits = [Habit]()
        SQLite.default.find(sql: sql, line: { Habit() }, datas: { (state, i, obj, name) in
            switch name {
            case "id":
                obj.id = Int(sqlite3_column_int64(state, i))
            case "name":
                obj.name = String(cString: sqlite3_column_text(state, i))
            case "type":
                obj.type = Int(sqlite3_column_int64(state, i))
            case "length":
                obj.length = Int(sqlite3_column_int64(state, i))
            case "flag":
                obj.flag = String(cString: sqlite3_column_text(state, i))
            case "message":
                obj.message = String(cString: sqlite3_column_text(state, i))
            default: break
            }
        }, next: { habits.append($0) })
        return habits
    }
    
    /**
     where = nil 查找所有数据
     where != nil 则添加约束条件
     */
    static func find(where value: String? = nil) -> [Habit] {
        var sql = "select * from \(table)"
        if let v = value {
            sql += " \(v);"
        } else {
            sql += ";"
        }
        return find(sql: sql)
    }
    
    // MARK: Insert
    
    /** 插入数据 */
    func insert() -> Bool {
        let sql = "insert into \(table) values(\(id), '\(name)', \(type), \(length), '\(flag)', '\(message)');"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Update
    
    /** 更新数据到数据库 */
    func update() -> Bool {
        let sql = "update \(table) set name = '\(name)', type = \(type), length = \(length), flag = '\(flag)', message = '\(message)' where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    /** 更新数据到数据库 */
    func update(_ values: String) -> Bool {
        let sql = "update \(table) set \(values) where id = \(id)"
        return SQLite.default.execut(sql: sql)
    }
    
    // MARK: Delete
    
    /** 删除数据 */
    func delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return SQLite.default.execut(sql: sql)
    }
}

