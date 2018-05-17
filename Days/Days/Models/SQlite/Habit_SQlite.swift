//
//  Habit_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension SQLite {
    
    /** 习惯颗粒 */
    class Habit: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "Habit_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Name */
        var name: String = ""
        /** 目标留言 */
        var message: String = ""
        
        /** 开始时间 */
        var start: Int = Date().time1970
        
        /** 目标，时间长度为秒，次数长度为1 */
        var goal: Int = 3600000
        /** 默认每天的频率，时间长度xx秒，次数的长度默认是 1 */
        var length: Int = 600
        
        /** 0: 时间; 1: 次数 */
        private var type: Int = 0
        /** 检测该习惯的统计方式是时长还是次数 */
        var is_time: Bool {
            set { type = (newValue ?  0 : 1) }
            get { return type == 0 }
        }
        
        /** 状态，0: 进行中; 1: 归档; */
        private var state: Int = 0
        /** 检测该习惯的状态是进行中，还是归档 */
        var is_runing: Bool {
            set { state = (newValue ?  0 : 1) }
            get { return state == 0 }
        }
        
        /** 图标名称 */
        var image: String = "alarm-clock"
        
        /** 颜色 */
        var color: Int = 0x3DAFFD
        
    }
    
}

