//
//  Event_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension SQLite {
    
    class Event: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Event_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 日期 */
        var date: Int = 0
        
        /** 名称 */
        var name: String = ""
        
        /** 详情 */
        var detail: String = ""
        
        /** 顺序 */
        var list: Int = 0
        
        /** 等级 */
        var level: Int = 0
        
        /** 是否已经完成 */
        private var complete_state: Int = 0
        /** 是否已经完成 */
        var is_complete: Bool {
            get { return complete_state == 1 }
            set { complete_state = newValue ? 1 : 0 }
        }
    }
    
}
