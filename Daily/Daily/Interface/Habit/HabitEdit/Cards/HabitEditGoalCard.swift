//
//  HabitEditGoalCard.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditGoalCard: HabitEditCard {

    /** 目标总时长，单位秒 */
    var goal: Int { return (Int(goal_text.text ?? "0") ?? 0) * 3600 }
    /** 每次投入时长，单位秒 */
    var length: Int { return (Int(length_text.text ?? "0") ?? 0) * 60 }
    
    // MARK: - Text
    
    @IBOutlet weak var goal_text: UITextField!
    @IBOutlet weak var length_text: UITextField!
    
    // MARK: - Reload
    
    override func reload() {
        goal_text.text = "\(habit.goal / 3600)"
        length_text.text = "\(habit.length / 60)"
    }
    
}
