//
//  HabitAddCard.swift
//  Daily
//
//  Created by 黄穆斌 on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditCard: CardView {

    /** Controller */
    var edit: HabitEditController { return table.controller as! HabitEditController }
    
    /** Log */
    var habit: Habit { return edit.habit }

}
