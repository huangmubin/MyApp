//
//  CalendarCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** 日历日期的时间状态 本日，本月，其他月 */
enum CalendarCellDateStatus {
    case other
    case normal
    case today
}

/** 日历日期的内容状态 */
enum CalendarCellContentStatus {
    case none
    case done
    case absence
}

class CalendarCell: CollectionViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var state_view: UIView!
    @IBOutlet weak var date_view: UIView!
    
    var date_status: CalendarCellDateStatus = .normal
    var status: CalendarCellContentStatus = .none
    
    func update_status() {
        view_bounds()
        
        switch date_status {
        case .other:
            day.textColor = Colors.text_hint_dark
            date_view.backgroundColor = Colors.clear
        case .normal:
            day.textColor = Colors.text_dark
            date_view.backgroundColor = Colors.clear
        case .today:
            day.textColor = Colors.text_light
            date_view.backgroundColor = Colors.red_deep
        }
        
        switch status {
        case .none:
            state_view.backgroundColor = Colors.clear
        case .done:
            state_view.backgroundColor = Colors.green_light
        case .absence:
            state_view.backgroundColor = Colors.red_light
        }
    }
    
    // MARK: - Frame
    
    override var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    func view_bounds() {
        state_view.layer.cornerRadius = 4
        date_view.layer.cornerRadius = date_view.bounds.height / 2
    }
    
}
