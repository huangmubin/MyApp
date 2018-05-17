//
//  HabitEditGoalCard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditGoalCard: CardView, KeyboardInputDelegate {
    
    override func reload() {
        reload_type()
        reload_goal()
        reload_frequency()
    }
    
    func reload_type() {
        if habit.value.is_time {
            type_timer_button.setTitleColor(
                Color.white,
                for: .normal
            )
            type_timer_view.backgroundColor = UIColor(habit.value.color)
            
            type_count_button.setTitleColor(
                Color.dark,
                for: .normal
            )
            type_count_view.backgroundColor = Color.gray_light
        } else {
            type_timer_button.setTitleColor(
                Color.dark,
                for: .normal
            )
            type_timer_view.backgroundColor = Color.gray_light
            
            type_count_button.setTitleColor(
                Color.white,
                for: .normal
            )
            type_count_view.backgroundColor = UIColor(habit.value.color)
        }
    }
    
    func reload_goal() {
        if habit.value.is_time {
            goal_unit_label.text = "小时"
            goal_button.setTitle(
                "\(habit.value.goal / 3600)",
                for: .normal
            )
        } else {
            goal_unit_label.text = "次"
            goal_button.setTitle(
                "\(habit.value.goal)",
                for: .normal
            )
        }
    }
    
    func reload_frequency() {
        if habit.value.is_time {
            frequency_button.setTitle(
                "\(habit.value.length / 60)",
                for: .normal
            )
            frequency_unit_label.text = "分钟 / 天"
        } else {
            frequency_button.setTitle(
                "\(habit.value.length)",
                for: .normal
            )
            frequency_unit_label.text = "次数 / 天"
        }
    }
    
    // MARK: - Type
    
    /**  */
    @IBOutlet weak var type_timer_button: UIButton!
    /**  */
    @IBOutlet weak var type_timer_view: View!
    
    /**  */
    @IBOutlet weak var type_count_button: UIButton!
    /**  */
    @IBOutlet weak var type_count_view: View!
    
    /**  */
    @IBAction func type_timer_action(_ sender: UIButton) {
        habit.value.is_time = true
        habit.value.goal *= 3600
        habit.value.length *= 60
        reload()
    }
    
    /**  */
    @IBAction func type_count_action(_ sender: UIButton) {
        habit.value.is_time = false
        habit.value.goal /= 3600
        habit.value.length /= 60
        reload()
    }
    
    // MARK: - Goal
    
    /**  */
    @IBOutlet weak var goal_unit_label: UILabel!
    /**  */
    @IBOutlet weak var goal_button: UIButton!
    /**  */
    @IBAction func goal_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.title.text = habit.value.is_time ? "计划时间" : "计划次数"
            view.input.text = "\(habit.value.goal)"
            view.input.keyboardType = .numberPad
            view.delegate = self
            view.id = "Goal"
            view.push()
        }
    }
    
    // MARK: - Frequency
    
    @IBOutlet weak var frequency_unit_label: UILabel!
    
    @IBOutlet weak var frequency_button: UIButton!
    
    @IBAction func frequency_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.title.text = habit.value.is_time ? "分钟 / 天" : "次数 / 天"
            view.input.text = "\(habit.value.length)"
            view.input.keyboardType = .numberPad
            view.delegate = self
            view.id = "Frequency"
            view.push()
        }
    }
    
    // MARK: - Keyboard Input
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        if input.id == "Goal" {
            if habit.value.is_time {
                habit.value.goal = Int(value)! * 3600
            } else {
                habit.value.goal = Int(value)!
            }
            reload_goal()
        } else {
            if habit.value.is_time {
                habit.value.length = Int(value)! * 60
            } else {
                habit.value.length = Int(value)!
            }
            reload_frequency()
        }
    }
    
}
