//
//  Ex_Array.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/9.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Count

extension Array {
    
    /** 快速添加所有值 */
    public func total(`where` body: (Element) -> Int) -> Int {
        var i = 0
        forEach { i += body($0) }
        return i
    }
    
}


// MARK: - Value

extension Array {
    
    /** 输出最大 Index */
    func index(_ sec: Int = 0) -> IndexPath {
        return IndexPath(row: count, section: sec)
    }
    
}
