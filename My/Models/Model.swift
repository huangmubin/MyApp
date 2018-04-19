//
//  Model.swift
//  My
//
//  Created by Myron on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

/** 数据模型 */
class Model {
    
    // MARK: - Init
    
    private init(_ v: Int) { }
    convenience init() {
        self.init(0)
        habit = Habit(self)
    }
    
    // MARK: - Values
    
    /** 习惯所属的 id */
    var id: Int { return habit.id }
    
    // MARK: - Habit
    
    /** 习惯数据 */
    var habit: Habit!
    
    // MARK: - Log
    
    /** 记录列表 */
    var logs: [Log] = []
    
    
    
}
