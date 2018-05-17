//
//  HabitEditTopCard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditTopCard: CardTopView {

    /**  */
    override func reload() {
        title.text = habit.value.name.isEmpty ? "新习惯" : habit.value.name
    }
    
    /** Cancel */
    override func cancel_action() {
        table.controller?.dismiss(animated: true, completion: nil)
    }
    
    /** Save */
    override func save_action() {
        table.controller?.dismiss(animated: true, completion: nil)
    }

}
