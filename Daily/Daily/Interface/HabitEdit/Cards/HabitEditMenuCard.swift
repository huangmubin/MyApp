//
//  HabitEditMenuCard.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditMenuCard: HabitEditCard {

    
    // MARK: - Close
    
    @IBAction func close_action(_ sender: UIButton) {
        edit.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Save
    
    @IBAction func save_action(_ sender: UIButton) {
        if let name = table.card(id: "Name") as? HabitEditNameCard {
            habit.name = name.value
        }
        if let goal = table.card(id: "Goal") as? HabitEditGoalCard {
            habit.goal = goal.goal
            habit.length = goal.length
        }
        if let message = table.card(id: "Message") as? HabitEditMessageCard {
            habit.message = message.value
        }
        if habit.id == 0 {
            habit.id = Habit.new_id
            edit.toSuperController(object: ["HabitAdd": habit])
        } else {
            edit.toSuperController(object: ["HabitEdit": habit])
        }
        edit.dismiss(animated: true, completion: nil)
    }
    
    
}
