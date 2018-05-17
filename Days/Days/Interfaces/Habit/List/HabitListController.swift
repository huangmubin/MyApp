//
//  HabitListController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitListController: ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.controller as? HabitEditController {
            edit.habit = Habit()
        }
    }
    
}
