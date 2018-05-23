//
//  HabitShowMenuCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowMenuCard: DaysCardView, HintViewDelegate {
    
    override func reload() {
        idle_button.selected_color = habit.color()
        if habit.value.is_runing {
            idle_button.status = .normal
            idle_button.setTitleColor(Color.dark, for: .normal)
        } else {
            idle_button.status = .selected
            idle_button.setTitleColor(Color.white, for: .normal)
        }
    }
    
    // MARK: - Idle
    
    @IBOutlet weak var idle_button: Button!
    
    @IBAction func idle_action(_ sender: Button) {
        if idle_button.is_selected {
            idle_button.status = .normal
            idle_button.setTitleColor(Color.dark, for: .normal)
        } else {
            idle_button.status = .selected
            idle_button.setTitleColor(Color.white, for: .normal)
        }
        habit.value.is_runing = !idle_button.is_selected
        habit.value.update()
    }
    
    // MARK: - Delete
    
    @IBAction func delete_action(_ sender: Button) {
        if let view = HintView.load(nib: nil) {
            view.title_label.text = "删除习惯"
            view.message_label.text = "删除 \(habit.value.name) 将抹除所有相关数据，不可恢复。是否确认？"
            view.delegate = self
            view.push()
        }
    }
    
    func hint_view(sure_action view: HintView) {
        self.habit.clear_sqlite()
        self.table.vc?.toSuperController(object: ["HabitDelete": habit])
        self.table.controller?.dismiss(animated: true, completion: nil)
    }
    
}
