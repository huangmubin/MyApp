//
//  HabitEditNameCard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditNameCard: CardView, KeyboardInputDelegate {
    
    override func reload() {
        if habit.value.name.isEmpty {
            name_button.setTitleColor(UIColor(155,155,155,1), for: .normal)
            name_button.setTitle("新习惯", for: .normal)
        } else {
            name_button.setTitleColor(UIColor(30,30,30,1), for: .normal)
            name_button.setTitle(habit.value.name, for: .normal)
        }
        if let top = table.card(id: "Top") as? HabitEditTopCard {
            top.right.isHidden = habit.value.name.isEmpty
        }
    }
    
    // MARK: - Name Button
    
    @IBOutlet weak var name_button: UIButton!
    
    @IBAction func name_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.push()
        }
    }
    
    // MARK: - Keyboard
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        habit.value.name = value
        reload()
    }
    
}
