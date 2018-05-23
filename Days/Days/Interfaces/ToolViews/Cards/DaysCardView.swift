//
//  DaysCardView.swift
//  Days
//
//  Created by Myron on 2018/5/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** DaysCardView */
public class DaysCardView: CardView {
    
    /** Card Date */
    var card: Card!
    
    /** Date if have */
    var date: Date {
        get { return (table.controller as! HabitShowController).date }
        set { (table.controller as! HabitShowController).date = newValue }
    }
    
}
