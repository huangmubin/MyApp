//
//  Chart_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension SQLite {
    
    class Chart: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Chart_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Habit 的 id */
        var habit: Int = 0
        
        /** 名称 */
        var name: String = ""
        
        /** 类型记录，0: 月份; 1: 周;  */
        private var type: Int = 0
        /** 是否是月份 */
        var is_month: Bool {
            get { return (type % 10) == 0 }
            set { type = (type / 10 * 10) + (newValue ? 0 : 1) }
        }
        
        private var is_log_type: Int = 1
        /** 是否是自创 */
        var is_custom: Bool {
            get { return (type / 10 % 10) == 0 }
            set {
                let more = type / 100 * 100
                let last = type % 10
                type = more + (newValue ? 0 : 10) + last
            }
        }
        
        /** 文本记录 */
        var note: String = ""
        
        /** 目标 */
        var goal: Int = 0
        
    }
    
}
