//
//  TimeUnit.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

enum TimeUnit {
    
    // 日 一 ~ 六
    case day([Bool])
    case week(Int)
    case month(Int)
    
    init(unit: Int) {
        if (unit & 0b1111111111) > 0 {
            var v = unit
            var data = [false,false,false,false,false,false,false]
            for i in (0 ..< 7).reversed() {
                data[i] = (v & 0b1) > 0
                v = v >> 1
            }
            self = TimeUnit.day(data)
        } else if (unit & 0b11111111110000000000) > 0 {
            let data = (unit & 0b11111111110000000000) >> 10
            self = TimeUnit.week(data)
        } else {
            let data = unit >> 20
            self = TimeUnit.month(data)
        }
    }
    
    var value: Int {
        var v = 0
        switch self {
        case .day(let d):
            for i in 0 ..< 7 {
                if d[i] { v |= 0b1 }
                v = v << 1
            }
            v = v >> 1
        case .week(let d):
            v = d << 10
        case .month(let d):
            v = d << 20
        }
        return v
    }
    
    /** 计算一个周期需要多少次 */
    var count: Int {
        switch self {
        case .day:
            return 1
        case .week(let v):
            return v
        case .month(let v):
            return v
        }
    }
    
    /** 计算当前日期是否需要进行 */
    func need(date: Date) -> Bool {
        switch self {
        case .day(let v):
            return v[date.weekday.rawValue]
        default: break
        }
        return true
    }
    
}
