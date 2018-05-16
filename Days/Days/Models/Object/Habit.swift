//
//  Habit.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

/** Habit Object */
class Habit {
    
    /** 数据 */
    let value: SQLite.Habit
    
    // MARK: - Init
    
    init(_ value: SQLite.Habit) {
        self.value = value
    }
    
}
