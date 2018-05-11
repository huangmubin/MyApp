//
//  EventEditCard.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventEditCard: CardView {

    /** Controller */
    var edit: EventEditController { return table.controller as! EventEditController }
    
    /** Habit */
    var obj: Habit.Event { return edit.event }

}
