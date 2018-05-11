//
//  ShowCalendarCard.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ShowCalendarCard: HabitShowCard, CalendarViewDelegate {

    // MARK: - Reload
    
    override func view_deploy() {
        self.frame.size.height = UIScreen.main.bounds.width - 40 + 120
    }
    
    // MARK: - SubView
    
    /**  */
    @IBOutlet weak var calendar: CalendarView! {
        didSet {
            calendar.delegate = self
        }
    }
    
    func calendar(view: CalendarView, update date: Date) {
        
    }
    
    func calendar(view: CalendarView, back_color_at index: IndexPath, date: Date) -> UIColor {
        let logs = obj.cache.logs(date.date)
        if logs.contains(where: { $0.is_sick }) {
            return UIColor(0xFF5A6F) // 红色
        } else if logs.count > 0 {
            return UIColor(0x50E3C2) // 绿色
        } else {
            return UIColor.white
        }
    }
    
    // MARK: - Actions
    
    /**  */
    @IBAction func append_log() {
        let log = Habit.Log(obj)
        let date = calendar.current
        log.date = date.date
        log.start = date.time1970
        show.performSegue(
            withIdentifier: "LogEdit",
            sender: log
        )
    }
    
    /**  */
    @IBAction func append_sick() {
        let log = Habit.Log(obj)
        let date = calendar.current
        log.is_sick = true
        log.date = date.date
        log.start = date.time1970
        show.performSegue(
            withIdentifier: "LogEdit",
            sender: log
        )
    }
    
    @IBAction func open_detail_logs(_ sender: UIButton) {
        show.performSegue(
            withIdentifier: "LogList",
            sender: calendar.date
        )
    }
}
