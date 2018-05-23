//
//  Card_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension SQLite {
    
    class Card: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Card_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 顺序 */
        var sort: Int = 0
        
        /** 名称 */
        var name: String = ""
        
        /** 详情 */
        var note: String = ""
        
        /** 类型 */
        var type: Int = 0
        
    }
    
}
