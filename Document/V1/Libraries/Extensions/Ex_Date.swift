//
//  Ex_Date.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Format to String

extension Date {
    
    /** to string with format */
    public func string(format: String? = nil) -> String {
        let format = format ?? "yyyy-MM-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

// MARK: - Time Zone

extension Date {
    
    /** Count the time zone */
    public static let time_zone: Double = {
        return Double(TimeZone.current.secondsFromGMT(for: Date()))
    }()
    
    /** offset the time zone */
    public func offset_time_zone() -> TimeInterval {
        return self.timeIntervalSince1970 + Date.time_zone
    }
    
}

// MARK: - Calendar

extension Date {
    
    // Day
    var year: Int { return Calendar.current.component(.year, from: self) }
    var month: Int { return Calendar.current.component(.month, from: self) }
    var day: Int { return Calendar.current.component(.day, from: self) }
    var weekday: Calendar.Week { return Calendar.Week.init(day: Calendar.current.component(.weekday, from: self) - 1) }
    var hour: Int { return Calendar.current.component(.hour, from: self) }
    var minute: Int { return Calendar.current.component(.minute, from: self) }
    var second: Int { return Calendar.current.component(.second, from: self) }
    var times: Int { return hour * 3600 + minute * 60 + second }
    
    var week_of_month: Int { return Calendar.current.component(.weekOfMonth, from: self) }
    var week_of_year: Int { return Calendar.current.component(.weekOfYear, from: self) }
    
    // Days
    var days_in_year: Int { return Calendar.days(in_year: year) }
    var days_in_month: Int { return Calendar.days(in_year: year, in_month: month) }
    
    // First
    func first_day_in_year() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self))
    }
    func first_day_in_month() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))
    }
    func first_day_in_week() -> Date? {
        var week_first: Date = Date()
        var interval: TimeInterval = 0
        if Calendar.current.dateInterval(of: .weekOfYear, start: &week_first, interval: &interval, for: self) {
            return week_first
        } else {
            return nil
        }
    }
    func first_time_in_day() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
    }
    
    // Advance
    func advance(time: TimeInterval) -> Date {
        return self.addingTimeInterval(time)
    }
}

// MARK: - Today

extension Date {
    
    /** 返回 20180120 这种格式的数据 */
    var today: Int {
        return self.year * 10000 + self.month * 100 + self.day
    }
    
    /** 20180112 */
    init?(today: Int) {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        if let date = format.date(from: today.description) {
            self = date
        } else {
            return nil
        }
    }
    
}
