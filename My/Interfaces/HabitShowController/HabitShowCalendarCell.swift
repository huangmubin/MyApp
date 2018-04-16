//
//  HabitShowCalendarCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/9.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitShowCalendarCell: HabitShowCell, CalendarViewDelegate {

    @IBOutlet weak var view: CalendarView! {
        didSet {
            view.current = Date()
            view.delegate = self
            view.day_collection.reloadData()
        }
    }
    
    // MARK: - CalendarViewDelegate
    
    func calendar(update view: CalendarView, date: Date) {
        obj.show.date = date
    }
    
    func calendar(open view: CalendarView, logs date: Date) {
        
    }
    
    func calendar(update view: CalendarView, times date: Date) -> Int {
        return obj.logs.logs(date.today).count
    }
    
    func calendar(update view: CalendarView, minutes date: Date) -> Int {
        return obj.logs.logs(date.today).total(where: { $0.duration })
    }
    
    func calendar(absent view: CalendarView, date: Date) -> Bool {
        return obj.logs.logs(date.today).contains(where: { $0.is_absent })
    }

}
