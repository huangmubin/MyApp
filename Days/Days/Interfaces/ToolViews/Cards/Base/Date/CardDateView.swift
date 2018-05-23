//
//  CardDateView.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardDateView: DaysCardView, CalendarCollectionDelegate, KeyboardDateInputDelegate {

    // MARK: - Override
    
    func update_date() { }
    
    // MARK: - Value
    
    var value: Date = Date() 
    
    // MARK: - Reload
    
    override func reload() {
        update_date_button()
        calendar.update(date: value)
    }
    
    // MARK: - Date
    
    @IBOutlet weak var date_button: UIButton!
    
    func update_date_button() {
        date_button.setTitle(
            DateFormatter("yyyy 年 MM 月 dd 日").string(from: value),
            for: .normal
        )
    }
    
    @IBAction func date_action(_ sender: UIButton) {
        if let view = KeyboardDateInput.load(nib: nil) {
            view.date_delegate = self
            view.year_view.text = value.year.description
            view.month_view.text = value.month.description
            view.day_view.text = value.day.description
            view.year_view.old = value.year.description
            view.month_view.old = value.month.description
            view.day_view.old = value.day.description
            view.day_view.max = value.days(.month)
            view.push()
        }
    }
    
    func keyboard_date(_ view: KeyboardDateInput, year: Int, month: Int, day: Int) {
        value = DateFormatter("yyyy-M-d").date(from: "\(year)-\(month)-\(day)")!
        update_date_button()
        calendar.update(date: value)
        update_date()
    }
    
    // MARK: - Open
    
    @IBOutlet weak var change_button: Button!
    
    @IBAction func change_action(_ sender: UIButton) {
        let h = self.frame.size.height == 60 ? (40 + UIScreen.main.bounds.width) : 60
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.size.height = h
            self.table.update_content_size()
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Calendar
    
    @IBOutlet weak var calendar: CalendarCollection! {
        didSet {
            calendar.delegate = self
        }
    }
    
    func calendarCollection(view: CalendarCollection, select_cell cell: CalendarCollectionCell) {
        value = cell.date
        update_date_button()
        update_date()
    }
    
    func calendarCollection(view: CalendarCollection, update_cell cell: CalendarCollectionCell) {
        if cell.date.month == value.month {
            cell.day.textColor = Color.gray_dark
        } else {
            cell.day.textColor = Color.gray_light
            cell.select.isHidden = true
        }
    }
    
}


