//
//  HabitShowCard.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowCard: CardView {
    
    /** 习惯对象 */
    var obj: Habit { return (table.controller as! HabitShowController).habit }
    
    /** 控制器 */
    var show: HabitShowController { return table.controller as! HabitShowController }
    
}
