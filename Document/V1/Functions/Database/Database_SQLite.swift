//
//  Database_SQLite.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit
import SQLite3

/**
 SQLite 3 数据库操作类
 
 * 打开数据库操作，如果文件不存在，则创建该文件
 int sqlite3_open(
     const char *filename,   /* Database filename (UTF-8)，数据库文件名 */
     sqlite3 **ppDb          /* OUT: SQLite db handle，数据库指针 */
 );
 
 * 关闭数据库
 int sqlite3_close(sqlite3 *ppDb);
 
 * 执行无返回值的数据库操作
 int sqlite3_exec(
     sqlite3* ppDb,                             /* An open database，数据库指针 */
     const char *sql,                           /* SQL to be evaluated，SQL 语句，以 \0 结尾 */
     int (*callback)(void*,int,char**,char**),  /* Callback function，执行完成的回调 */
     void *,                                    /* 1st argument to callback，传递回回调函数的第一个参数 */
     char **errmsg                              /* Error msg written here，错误信息 */
 );
 
 * 执行和修改
 int sqlite3_bind_int(
     sqlite3_stmt* stmt,
     int col,
     int val
 )
 sqlite3_bind_text(
     sqlite3_stmt* stmt,
     int col,
     void* text,
     lenght int,
     void (*callback)(void*)
 )
 
 */
// MARK: - SQLite
let sqlite: Database_SQLite = Database_SQLite(name: "MySQLiteDatabse")
class Database_SQLite {
    
    // MARK: Init
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: Values
    
    /** 数据库名称 */
    var name: String = ""
    /** 数据库指针 */
    var db: OpaquePointer? = nil
    
    // MARK: Create Tables
    
    /** Call when open */
    fileprivate func create_tables() {
        Habit.table_create()
        HabitLog.table_create()
    }
    
    /** Get the last new id */
    func last_id() -> Int {
        return Int(sqlite3_last_insert_rowid(db))
    }
    
}

// MARK: - Open Close

extension Database_SQLite {
    
    /** 打开数据库，如果不存在就创建它。 */
    @discardableResult
    func open() -> Bool {
        objc_sync_enter(self)
        
        if db != nil {
            objc_sync_exit(self)
            return true
        }
        
        let path = "\(NSHomeDirectory())/Documents/\(name).sqlite"
        guard let c_path = path.cString(using: .utf8) else {
            objc_sync_exit(self)
            return false
        }
        
        if sqlite3_open(c_path, &db) != SQLITE_OK {
            print("Database_SQLite: open failed - \(path)")
            objc_sync_exit(self)
            return false
        }
        
        print("Database_SQLite: open success - \(path)")
        create_tables()
        objc_sync_exit(self)
        return true
    }
    
    /** 关闭数据库 */
    @discardableResult
    func close() -> Bool {
        objc_sync_enter(self)
        
        let result = sqlite3_close(db) == SQLITE_OK
        if result {
            db = nil
            print("Database_SQLite: close success")
        } else {
            print("Database_SQLite: close failed - \(error)")
        }
        
        objc_sync_exit(self)
        return result
    }
    
}

// MARK: - Execute

extension Database_SQLite {
    
    /** 执行不返回数据的 SQL 语句: 创表、更新、插入和删除操作. */
    func execut(sql: String) -> Bool {
        objc_sync_enter(self)
        
        if db == nil {
            print("Database_SQLite: execut db open faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            print("Database_SQLite: execut c_sql faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(db, c_sql, nil, nil, &error) != SQLITE_OK {
            print("Database_SQLite: execut faild - \(sql) - \(self.error)")
            objc_sync_exit(self)
            return false
        }
        
        print("Database_SQLite: execut success - \(sql)")
        objc_sync_exit(self)
        return true
    }
    
    /** 根据 sql 语句查询内容 */
    func find(sql: String) -> [[String: Any]] {
        objc_sync_enter(self)
        
        if db == nil {
            print("Database_SQLite: execut db open faild - \(sql)")
            objc_sync_exit(self)
            return []
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            print("Database_SQLite: execut c_sql faild - \(sql)")
            objc_sync_exit(self)
            return []
        }
        
        // 执行检查
        var datas: [[String: Any]] = []
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            print("Database_SQLite: find faild - \(sql) - \(self.error)")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                let columns = sqlite3_column_count(statement)
                var row_data: [String: Any] = [:]
                for i in 0 ..< columns { // 遍历每一列
                    let type = sqlite3_column_type(statement, i)
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))!
                    let name = String(cString: chars, encoding: .utf8)!
                    
                    var value: Any
                    switch type {
                    case SQLITE_INTEGER: value = sqlite3_column_int(statement, i)
                    case SQLITE_FLOAT:   value = sqlite3_column_double(statement, i)
                    case SQLITE_TEXT:    value = String(cString: UnsafePointer<CUnsignedChar>(sqlite3_column_text(statement, i)))
                    case SQLITE_BLOB:    value = Data(bytes: sqlite3_column_blob(statement, i), count: Int(sqlite3_column_bytes(statement, i)))
                    default:             value = ""
                    }
                    
                    row_data[name] = value
                }
                datas.append(row_data)
            }
        }
        sqlite3_finalize(statement)
        
        print("Database_SQLite: find success - \(sql) - \(datas)")
        objc_sync_exit(self)
        return datas
    }
    
    /** 根据 sql 语句查询内容 */
    func find<T: AnyObject>(sql: String, line: () -> T, datas: (OpaquePointer?, Int32, T, String) -> Void, next: (T) -> Void) {
        objc_sync_enter(self)
        
        if db == nil {
            print("Database_SQLite: execut db open faild - \(sql)")
            objc_sync_exit(self)
            return
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            print("Database_SQLite: execut c_sql faild - \(sql)")
            objc_sync_exit(self)
            return
        }
        
        // 执行检查
        //var datas: [[String: Any]] = []
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            print("Database_SQLite: find faild - \(sql) - \(self.error)")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                let object = line()
                let columns = sqlite3_column_count(statement)
                for i in 0 ..< columns { // 遍历每一列
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))!
                    let name = String(cString: chars, encoding: .utf8)!
                    datas(statement, i, object, name)
                }
                next(object)
            }
        }
        sqlite3_finalize(statement)
        
        print("Database_SQLite: find success - \(sql) - \(datas)")
        objc_sync_exit(self)
    }
    
}

// MARK: - Tools

extension Database_SQLite {
    
    /** 错误信息 */
    var error: String {
        return String(validatingUTF8:sqlite3_errmsg(db)) ?? ""
    }
    
    /** 约束类型 */
    enum primary_key: String {
        case unull = "not null"
        case unique = "unique"
        case key = "primary key"
        case check = "check"
        case `default` = "default"
        case auto = "autoincreatement"
    }
    
    /** 变量类型 */
    enum type: String {
        case null = "null"
        case int  = "integer"
        case real = "real"
        case text = "text"
        case blob = "blob"
    }
    
}

// MARK: - Normal Operator

extension Database_SQLite {
    
    /**
     sql = "insert into <table_name> (<column_name>[, ...]) values(?[, ...]);"
     "insert into t_person(name, age) values(?, ?);";
     */
    func insert(sql: String, datas: (OpaquePointer?) -> Void) -> Bool {
        objc_sync_enter(self)
        
        if db == nil {
            print("Database_SQLite: execut db open faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            print("Database_SQLite: insert c_sql faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        var state: OpaquePointer? = nil
        
        if sqlite3_prepare(db, c_sql, -1, &state, nil) != SQLITE_OK {
            sqlite3_finalize(state)
            print("Database_SQLite: insert prepare faild - \(sql) - \(self.error)")
            return false
        }
        
        datas(state)
        
        if sqlite3_step(state) != SQLITE_DONE {
            sqlite3_finalize(state)
            print("Database_SQLite: insert step faild - \(sql) - \(self.error)")
            return false
        }
        
        sqlite3_finalize(state)
        print("Database_SQLite: insert success - \(sql)")
        objc_sync_exit(self)
        return true
    }
    
}

// MARK: - Normal Operator Tint

extension Database_SQLite {
    
    /**
     sql = "create table if not exists <table_name> (<column_name primary_keys>[, ...]);"
     "create table if not exists t_person(id integer primary key autoincrement, name text, age integer);";
     func execut(sql: String) -> Bool
     */
    private func create_table() { }
    
    
    /**
     sql = "insert into <table_name> (<column_name>[, ...]) values(?[, ...]);"
     "insert into t_person(name, age) values(?, ?);";
     */
    private func insert_data() -> Bool {
        let sql = "insert into <table_name> (<column_name>[, ...]) values(?[, ...]);"
        objc_sync_enter(self)
        
        if db == nil {
            print("Database_SQLite: execut db open faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            print("Database_SQLite: insert c_sql faild - \(sql)")
            objc_sync_exit(self)
            return false
        }
        
        var state: OpaquePointer? = nil
        
        if sqlite3_prepare(db, c_sql, -1, &state, nil) != SQLITE_OK {
            sqlite3_finalize(state)
            print("Database_SQLite: insert prepare faild - \(sql) - \(self.error)")
            return false
        }
        
        // 第二个参数索引从1开始，表示 SQL 语句中的 column 列表位置，
        sqlite3_bind_null(state, 1)
        // 第三个参数是数据 32 位
        sqlite3_bind_int(state, 2, 100)
        // 第三个参数是数据 CString，第四个参数是字符串长度-1是自动计算，第五个参数是回调
        let text = "text".cString(using: .utf8)!
        sqlite3_bind_text(state, 3, text, -1, nil)
        // 第三个参数是数据指针，第四个是长度不能-1，第五个是回调
        let data = Data().map({$0})
        sqlite3_bind_blob(state, 4, data, Int32(data.count), nil)
        
        if sqlite3_step(state) != SQLITE_DONE {
            sqlite3_finalize(state)
            print("Database_SQLite: insert step faild - \(sql) - \(self.error)")
            return false
        }
        
        sqlite3_finalize(state)
        print("Database_SQLite: insert success - \(sql)")
        objc_sync_exit(self)
        return true
    }
    
    
    
    /**
     sql = "update <table_name> set <column_name> = <new_value>[, <column_name> = <new_value> ...] where <column_name> = <old_value>"
     let sql = "update UserTable set username = '\(toName)' where username = '\(name)'";
     func execut(sql: String) -> Bool
     */
    private func update_data() { }
    
    /**
     sql = "delete from <table_name> where <column_name> = <old_value>"
     let sql = "delete from UserTable where username = '\(username)'";
     func execut(sql: String) -> Bool
     */
    private func delete_data() { }
}

