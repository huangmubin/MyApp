//
//  iMonthSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol i_DateSelectorDelegate: NSObjectProtocol {
    func i_date_selector_update(year: Int, month: Int, day: Int, hour: Int, minute: Int)
}

class iDateSelector: View, i_SelectorDelegate {

    // MARK: - Data
    
    private let format = DateFormatter()
    
    var date: Date {
        set {
            year?.scroll(data: newValue.year.description, animate: true)
            month?.scroll(data: newValue.month.description, animate: true)
            day?.data = iSelector.days(day?.cells ?? 5, year: newValue.year, month: newValue.month)
            day?.scroll(data: newValue.day.description, animate: true)
            hour?.scroll(data: newValue.hour.description, animate: true)
            minute?.scroll(data: newValue.minute.description, animate: true)
        }
        get {
            format.dateFormat = "yyyy-M-d H:m"
            let date_str = "\(year?.int ?? 2018)-\(month?.int ?? 1)-\(day?.int ?? 1) \(hour?.int ?? 8):\(minute?.int ?? 0)"
            return format.date(from: date_str) ?? Date()
        }
    }
    
    func date(year: Int?, month: Int?, day: Int?, hour: Int?, minut: Int?) -> Date {
        let today = Date()
        let y = year ?? (self.year?.int ?? today.year)
        let m = month ?? (self.month?.int ?? today.month)
        let d = day ?? (self.day?.int ?? today.day)
        let h = hour ?? (self.hour?.int ?? today.hour)
        let mi = minut ?? (self.minute?.int ?? today.minute)
        format.dateFormat = "yyyy-M-d H:m"
        let str = "\(y)-\(m)-\(d) \(h):\(mi)"
        return format.date(from: str) ?? Date()
    }
    
    // MARK: - Delegate
    
    weak var delegate: i_DateSelectorDelegate?
    
    // MARK: - year
    
    @IBOutlet weak var year: iSelector!
    
    // MARK: - month
    
    @IBOutlet weak var month: iSelector!
    
    // MARK: - day
    
    @IBOutlet weak var day: iSelector!
    
    // MARK: - hour
    
    @IBOutlet weak var hour: iSelector!
    
    // MARK: - minute
    
    @IBOutlet weak var minute: iSelector!
    
    // MARK: - Deploy
    
    override func view_deploy() {
        super.view_deploy()
        DispatchQueue.main.async {
            let date = Date()
            self.year?.scroll(data: date.year.description, animate: false)
            self.month?.scroll(data: date.month.description, animate: false)
            self.day?.scroll(data: date.day.description, animate: false)
            self.hour?.scroll(data: date.hour.description, animate: false)
            self.minute?.scroll(data: date.minute.description, animate: false)
        }
    }
    
    // MARK: - iSelectorDelegate
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        if iSel === year || iSel === month {
            let new_days = iSelector.days(day?.cells ?? 5, year: year.int, month: month.int)
            day.data = new_days
            day.reload()
        }
        delegate?.i_date_selector_update(
            year: year.int,
            month: month.int,
            day: day.int,
            hour: hour.int,
            minute: minute.int
        )
    }
    
}
