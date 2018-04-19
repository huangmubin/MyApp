//
//  HabitLogTimeCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogTimeCell: HabitLogCell, i_SelectorDelegate {

    @IBOutlet weak var start: iTimeSelector!
    @IBOutlet weak var end: iTimeSelector!
    
    override func view_load() {
        log.time = self
    }
    
    override func view_reload() {
        DispatchQueue.main.async {
            self.start.update(date: self.log.log.start)
            self.end.update(date: self.log.log.end)
        }
    }
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        let day_s = start.date(day: nil)
        let day_e = end.date(day: nil)
        if day_s >= day_e {
            if iSel === start.hour || iSel === start.minute {
                end.update(date: day_s.advance(time: 60))
            } else {
                start.update(date: day_e.advance(time: -60))
            }
        }
    }
    
}
