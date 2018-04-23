//
//  HabitEditNameCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditNameCell: HabitEditCell {

    /** name text view */
    @IBOutlet weak var view: UITextView!
    
    override func view_reload() {
        view.text = edit?.habit.name
    }
    
}
