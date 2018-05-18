//
//  HabitShowCalendarCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowCalendarCard: CardView, KeyboardDateInputDelegate {

    // MARK: - Date
    
    @IBAction func date_action(_ sender: UIButton) {
        if let view = KeyboardDateInput.load(nib: nil) {
            view.date_delegate = self
            view.year_view.text = date.year.description
            view.month_view.text = date.month.description
            view.day_view.text = date.day.description
            view.year_view.old = date.year.description
            view.month_view.old = date.month.description
            view.day_view.old = date.day.description
            view.day_view.max = date.days(.month)
            print(view.day_view.max)
            view.push()
        }
    }
    
    func keyboard_date(_ view: KeyboardDateInput, year: Int, month: Int, day: Int) {
        
    }
    

}
