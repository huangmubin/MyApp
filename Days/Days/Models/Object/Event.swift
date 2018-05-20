//
//  Event.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Event {
    
    /** Sqlite Value Date */
    let value: SQLite.Event
    
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Event) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.Event()
    }
    
    // MARK: - Find
    
    class func find(habit: Habit) -> [Event] {
        return SQLite.Event.find(where: "habit = \(habit.value.id)").map({
            let event = Event($0)
            event.habit = habit
            return event
        })
    }
    
}
