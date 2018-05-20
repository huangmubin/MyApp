//
//  Chart.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Chart {
    
    /** Sqlite Value Date */
    let value: SQLite.Chart
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Chart) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.Chart()
    }
    
    // MAKR: - Units
    
    /** date */
    var date: Date = Date()
    
    /** Units */
    var units: [ChartUnit] = []
    
    func update(date: Date) {
        self.date = date
        let first = value.is_month ? date.first(.month) : date.first(.weekday)
        let length = (value.is_month ? date.days(.month) : 7)
        var dates: [ChartUnit] = []
        if value.is_custom {
            dates = ChartUnit.find(chart: value.id, start: first.date, end: first.advance(.day, length).date)
        } else {
            let logs = SQLite.Log.find(where: "habit = \(value.habit) and date >= \(first.date) and date <= \(first.advance(.day, length).date)")
            for log in logs {
                if let date = dates.find(condition: { $0.value.date == log.date }) {
                    date.value.length += log.length
                } else {
                    let unit = ChartUnit()
                    unit.value.chart = self.value.id
                    unit.value.date = log.date
                    unit.value.length = log.length
                    dates.append(unit)
                }
            }
        }
        units.removeAll(keepingCapacity: true)
        for i in 0 ..< length {
            let now = first.advance(.day, i)
            if let unit = dates.find(condition: { $0.value.date == now.date }) {
                units.append(unit)
            } else {
                let empty = ChartUnit()
                empty.value.date = now.date
                empty.value.chart = value.id
                units.append(empty)
            }
        }
    }
    
    func date_range() -> (Date, Date) {
        let first = value.is_month ? date.first(.month) : date.first(.weekday)
        let length = (value.is_month ? date.days(.month) : 7)
        return (first, first.advance(.day, length))
    }
    
}
