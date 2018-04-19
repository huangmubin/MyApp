//
//  Ex_DateFormatter.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /** Init */
    public convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
    
}
