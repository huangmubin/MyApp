//
//  Time_Enums.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

enum TimeUnit: Int {
    case day = 0
    case week = 1
    case month = 2
    
    init(value: Int?) {
        self = TimeUnit(rawValue: value ?? 0) ?? .day
    }
}
