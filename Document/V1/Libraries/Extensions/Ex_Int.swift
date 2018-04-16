//
//  Ex_Int.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/26.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

extension Int {
    
    /** 输出成为多少小时，多少分钟 */
    var time: String {
        if self >= 60 {
            if self % 60 == 0 {
                return "\(self / 60) hour"
            } else {
                return "\(self / 60) hour \(self % 60) minute"
            }
        } else {
            return "\(self) minute"
        }
    }
    
}
