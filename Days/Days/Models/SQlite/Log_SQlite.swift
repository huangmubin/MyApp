//
//  Log_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension SQLite {
    
    class Log: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Log_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 日期 */
        var date: Int = 0
        
        /** 开始时间，也是记录时间 */
        var start: Int = 0
        /** 时间长度，按秒算，或者次数，按次算 */
        var length: Int = 0
        /** 结束时间 */
        var end: Int { return start + length }
        /** 开始时间 Date 格式 */
        var date_s: Date { return Date(time: start) }
        /** 结束时间 Date 格式 */
        var date_e: Date { return Date(time: end) }
        
        /** 文本记录 */
        var note: String = ""
        
        /** 类型记录，0: 正常打卡; 1: 请假打卡; */
        private var type: Int = 0
        /** 是否是请假 */
        var is_sick: Bool {
            get { return type == 1 }
            set { type = newValue ? 1 : 0 }
        }
        
    }
    
}
