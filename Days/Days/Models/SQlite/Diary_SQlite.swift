//
//  Diary_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/21.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension SQLite {
    
    class Diary: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Diary_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 日期 */
        var date: Int = 0
        
        /** 详情 */
        var note: String = ""
        
    }
    
}
