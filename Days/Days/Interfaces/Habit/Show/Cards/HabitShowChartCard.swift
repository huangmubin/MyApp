//
//  HabitShowChartCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowChartCard: CardChartView {
    
    override func reload() {
        chart = habit.chart_log_find()
        chart.update(date: date)
        append_button.isHidden = true
        super.reload()
    }
    
}
