//
//  MonthSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class MonthSelector: View {

    var year: Int {
        return year_selector.index + 2018
    }
    
    var month: Int {
        return month_selector.index + 1
    }
    
    var date: Date {
        let format = DateFormatter()
        format.dateFormat = "yyyy-M"
        return format.date(from: "\(year)-\(month)")!
    }
    
    // MARK: - Views
    
    @IBOutlet weak var year_selector: VerticalSelector! {
        didSet {
            year_selector.datas = VerticalSelector.years
        }
    }
    @IBOutlet weak var month_selector: VerticalSelector! {
        didSet {
            month_selector.datas = VerticalSelector.months
        }
    }
    

}
