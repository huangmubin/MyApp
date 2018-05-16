//
//  File.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

/** Log 数据 */
class Log {
    
    /** 数据 */
    let value: SQLite.Log
    /** Habit */
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Log, _ habit: Habit) {
        self.value = value
        self.habit = habit
    }
    
}
