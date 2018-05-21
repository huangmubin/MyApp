//
//  Diary.swift
//  Days
//
//  Created by Myron on 2018/5/21.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

class Diary {
    
    /** Sqlite Value Date */
    let value: SQLite.Diary
    
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Diary) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.Diary()
    }
    
}
