//
//  HabitShowCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitShowCell: TableViewCell {

    /** Show Controller */
    var show: HabitShowController { return controller as! HabitShowController }
    /** Habti Obj */
    var obj: Habit { return show.habit }
    
}
