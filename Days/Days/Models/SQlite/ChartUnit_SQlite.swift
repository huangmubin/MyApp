//
//  ChartUnit_SQlite.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension SQLite {
    
    class ChartUnit: SQLiteProtocol {
        
        /** Init */
        required init() {}
        
        /** table name */
        static var table: String = "ChartUnit_SQlite"
        
        /** id */
        var id: Int = 0
        
        /** Chart 的 id */
        var chart: Int = 0
        
        /** 日期 */
        var date: Int = 0
        
        /** 时间长度，按秒算，或者次数，按次算 */
        var length: Int = 0
        
    }
    
}
