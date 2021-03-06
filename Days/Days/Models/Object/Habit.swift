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
    
    /** Delete Dates */
    func clear_sqlite() {
        //delete from \(table) where id = \(id);
        let _ = SQLite.default.execut(sql: "delete from \(SQLite.Log.table) where habit = \(value.id);")
        
        let charts = SQLite.Chart.find(where: "habit = \(value.id)")
        for chart in charts {
            let _ = SQLite.default.execut(sql: "delete from \(SQLite.ChartUnit.table) where chart = \(chart.id);")
            let _ = chart.delete()
        }
        
        let _ = SQLite.default.execut(sql: "delete from \(SQLite.Event.table) where habit = \(value.id);")
        let _ = SQLite.default.execut(sql: "delete from \(SQLite.Diary.table) where habit = \(value.id);")
        let _ = SQLite.default.execut(sql: "delete from \(SQLite.Log.table) where habit = \(value.id);")
    }
    
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
            text = Habit.format(time: length)
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
    
    // MARK: - Chart
    
    /** Insert Log chart */
    func chart_log_create() {
        let chart = Chart()
        chart.value.habit = value.id
        chart.value.name  = "图表"
        chart.value.goal  = value.length
        chart.value.note  = "每日打卡记录分析"
        chart.value.is_custom = false
        chart.value.insert()
    }
    
    /** 查找 Log 图标数据 */
    func chart_log_find() -> Chart {
        let chart = Chart(SQLite.Chart.find(where: "habit = \(value.id)").find(condition: {
            !$0.is_custom })!)
        chart.value.goal = value.length
        chart.habit = self
        return chart
    }
    
    // MARK: - Diary
    
    var diaries: [Diary] = []
    
    /** Find the diary in date (20180101) */
    func diary_find(date: Int) -> Diary {
        if let i = diaries.index(where: { $0.value.date == date }) {
            return diaries[i]
        } else {
            if let obj = SQLite.Diary.find(where: "habit = \(value.id) and date = \(date)").first {
                let diary = Diary(obj)
                diary.habit = self
                diaries.append(diary)
                return diary
            }
        }
        let diary = Diary()
        diary.habit = self
        diary.value.habit = value.id
        diary.value.date = date
        diary.value.id = SQLite.Diary.new_id
        diary.value.insert()
        diaries.append(diary)
        return diary
    }
    
    // MARK: - Cards
    
    /** 创建默认的卡片 */
    func cards_create() {
        for data in [
            ("日期选择", "显示并日期，让其他与时间有关的卡片可以进行时间轴定位。", 0),
            ("打卡按钮", "请假，打卡，或查看你的所有打卡记录。", 1),
            ("记录图表", "显示你每日的打卡记录时长或次数，让你最直观的看到自己最近一段时间是否达成。", 21),
            ("里程碑", "将你的习惯分成一个个小目标，让自己不断达成，保持干劲。", 3),
            ("日记", "用文字记录下这个习惯的经历，成为自己终身的记忆。", 4)
        ] {
            let card = SQLite.Card()
            card.id = SQLite.Card.new_id
            card.habit = value.id
            card.sort = card.id
            card.name = data.0
            card.note = data.1
            card.type = data.2
            let _ = card.insert()
        }
    }
    
    /** Find the cards */
    func cards_find() -> [Card] {
        return SQLite.Card.find(where: "habit = \(value.id)").map({ Card($0) })
    }
    
}

// MARK: - Format

extension Habit {
    
    /** Time to Text */
    class func format(time: Int) -> String {
        switch time {
        case 0 ..< 60:
            return "\(time)秒"
        case 60 ..< 3600:
            if time % 60 == 0 {
                return "\(time / 60)分钟"
            } else {
                return String(format: "%.1f分钟", Double(time) / 60)
            }
        default:
            if time % 3600 == 0 || time < 3960 {
                return "\(time / 3600)小时"
            } else {
                return String(format: "%.1f小时", Double(time) / 3600)
            }
        }
    }
    
}
