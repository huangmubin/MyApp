//
//  ChartUnit.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ChartUnit {
    
    /** Sqlite Value Date */
    let value: SQLite.ChartUnit
    
    // MARK: - Init
    
    init(_ value: SQLite.ChartUnit) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.ChartUnit()
    }
    
    // MARK: - Sqlite
    
    class func find(chart: Int, start: Int, end: Int) -> [ChartUnit] {
        let units = SQLite.ChartUnit.find(where: "chart = \(chart) and date >= \(start) and date <= \(end)")
        return units.map({ ChartUnit($0) })
    }
    
}
