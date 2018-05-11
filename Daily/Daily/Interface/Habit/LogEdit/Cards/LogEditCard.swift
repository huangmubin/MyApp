//
//  LogEditCard.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditCard: CardView {

    /** Controller */
    var edit: LogEditController { return table.controller as! LogEditController }
    
    /** Log */
    var log: Habit.Log { return edit.log }

}
