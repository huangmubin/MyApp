//
//  LogEditTimeCard.swift
//  Daily
//
//  Created by 黄穆斌 on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditTimeCard: LogEditCard, i_SelectorDelegate {

    /**  */
    var value_start: Int {
        let date = Date(log.date)
        return start.date(year: date.year, month: date.month, day: date.day).time1970
    }
    
    /**  */
    var value_lenght: Int {
        let date = Date(log.date)
        return end.date(year: date.year, month: date.month, day: date.day).time1970 - start.date(year: date.year, month: date.month, day: date.day).time1970
    }
    
    
    // MARK: - Layout
    
    @IBOutlet weak var layout_height: NSLayoutConstraint!
    
    // MARK: - Open Action
    
    @IBAction func open_action(_ sender: UIButton) {
        if self.frame.height < 200 {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = 200
                self.table.update_content_size()
                self.layout_height.constant = 150
                self.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = 100
                self.table.update_content_size()
                self.layout_height.constant = 20
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Time
    
    @IBOutlet weak var start: iDateSelector!
    @IBOutlet weak var end: iDateSelector!
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        if iSel === start.hour || iSel === start.minute {
            let date = Date(log.date)
            let s_time = start.date(year: date.year, month: date.month, day: date.day)
            if s_time.time1970 + log.obj.length < date.time1970 + 86399 {
                let e_time = end.date(year: date.year, month: date.month, day: date.day)
                if s_time.time1970 + log.obj.length > e_time.time1970 {
                    end.update(date: s_time.advance(TimeInterval(log.obj.length)))
                }
            } else {
                start.update(date: date.advance(TimeInterval(86399-log.obj.length)))
                end.update(date: date.advance(TimeInterval(86399)))
            }
        } else {
            let date = Date(log.date)
            let e_time = end.date(year: date.year, month: date.month, day: date.day)
            if e_time.time1970 - log.obj.length >= date.time1970 {
                let s_time = start.date(year: date.year, month: date.month, day: date.day)
                if e_time.time1970 - log.obj.length < s_time.time1970 {
                    start.update(date: e_time.advance(TimeInterval(-log.obj.length)))
                }
            } else {
                start.update(date: date)
                end.update(date: date.advance(TimeInterval(log.obj.length)))
            }
        }
    }
    
    // MARK: - Reload
    
    override func reload() {
        start.update(date: Date(time: log.start), animate: false)
        end.update(date: Date(time: log.end), animate: false)
    }
    
}
