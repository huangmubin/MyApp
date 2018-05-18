//
//  HabitShowTopCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowTopCard: CardTopView {

    override func reload() {
        title.text = habit.value.name
    }
    
    override func cancel_action() {
        table.controller?.dismiss(animated: true, completion: nil)
    }
    
    override func save_action() {
        
    }
}
