//
//  HabitShowMenuCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowMenuCard: CardView {

    override func reload() {
        idle_button.selected_color = habit.color()
        idle_button.status = habit.value.is_runing ? .normal : .selected
    }
    
    // MARK: - Idle
    
    @IBOutlet weak var idle_button: Button!
    
    @IBAction func idle_action(_ sender: Button) {
        idle_button.status = idle_button.is_selected ? .normal : .selected
        habit.value.is_runing = !idle_button.is_selected
        habit.value.update()
    }
    
    // MARK: - Delete
    
    @IBAction func delete_action(_ sender: Button) {
        
    }
    
}
