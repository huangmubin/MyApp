//
//  Habit.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol HabitObject {
    var habit: Habit! { get set }
}

extension CardView {
    var habit: Habit {
        return (table.controller as! HabitObject).habit
    }
}

/** Habit Object */
class Habit {
    
    /** 数据 */
    let value: SQLite.Habit
    
    // MARK: - Init
    
    init(_ value: SQLite.Habit) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.Habit()
    }
    
    // MARK: - Logs
    
    /** Logs Cache */
    private var _logs: [Int: [Log]] = [:]
    
    /** Logs */
    func logs(date: Int) -> [Log] {
        if let logs = _logs[date] {
            return logs
        } else {
            let logs = Log.find(habit: self, date: date)
            _logs[date] = logs
            return logs
        }
    }
    
    /** remove and delete */
    func logs(remove index: IndexPath) -> Log {
        let date = dates[index.section]
        var logs = self.logs(date: date)
        let log = logs.remove(at: index.row)
        _logs[date] = logs
        return log
    }
    
    /** Append log to cache */
    func append(log: Log, date: Int) {
        var logs = self.logs(date: date)
        logs.append(log)
        logs.sort(by: { $0.value.start < $1.value.start })
        _logs[date] = logs
    }
    
    // MARK: - Dates
    
    /** Dates */
    var dates: [Int] = []
    
    func update_dates() {
        dates.removeAll(keepingCapacity: true)
        SQLite.default.find(
            sql: "select distinct date from \(SQLite.Log.table) where habit = \(value.id);",
            default: 0,
            datas: { dates.append($0) }
        )
    }
    
    // MARK: - Length
    
    /** 某一天已经完成的长度，秒或次数 */
    func length(at_date date: Int) -> Int {
        return logs(date: date).count(value: { $0.value.length })
    }
    
    /** 某一天已经完成的长度文本，秒或次数 */
    func length_str(at_date date: Int) -> String {
        let length = self.length(at_date: date)
        var text = ""
        if value.is_time {
            switch length {
            case 0 ..< 60:
                text = "\(length)秒"
            case 60 ..< 3600:
                if length % 60 == 0 {
                    text = "\(length / 60)分钟"
                } else {
                    text = String(format: "%.1f分钟", Double(length) / 60)
                }
            default:
                if length % 3600 == 0 || length < 3960 {
                    text = "\(length / 3600)小时"
                } else {
                    text = String(format: "%.1f小时", Double(length) / 3600)
                }
            }
        } else {
            text = "\(length)次"
        }
        return text
    }
    
    /** nil is sick, 0 ~ 1 is progress */
    func status(at_date date: Int) -> CGFloat? {
        let logs = self.logs(date: date)
        if logs.contains(where: { $0.value.is_sick }) {
            return nil
        } else {
            return CGFloat(logs.count(value: { $0.value.length })) / CGFloat(value.length)
        }
    }
    
    // MARK: - Progress
    
    /** Progress at date */
    func progress(at_date date: Int) -> CGFloat {
        let did = CGFloat(length(at_date: date))
        let wil = CGFloat(value.length)
        return did / wil
    }
    
    // MARK: - UI
    
    /** UIImage */
    func image() -> UIImage {
        return ImageController.image(name: value.image, color: value.color)
    }
    
    /** Color */
    func color() -> UIColor {
        return UIColor(value.color)
    }
    
    // MARK: - Step
    
    /** Count the step on length */
    func step() -> Int {
        if value.is_time {
            let i = value.length / 60 / 3
            return max(i / 5 * 5, 1)
        } else {
            let i = value.length / 3
            return max(i / 5 * 5, 1)
        }
    }
    
}
