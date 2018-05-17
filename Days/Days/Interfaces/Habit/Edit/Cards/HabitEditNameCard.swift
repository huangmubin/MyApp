//
//  HabitEditNameCard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditNameCard: CardView, KeyboardInputDelegate {
    
    // MARK: - Name Button
    
    @IBOutlet weak var name_button: UIButton! {
        didSet {
            update_name_button(value: "")
        }
    }
    
    @IBAction func name_action(_ sender: UIButton) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.push()
        }
    }
    
    func update_name_button(value: String) {
        if value.isEmpty {
            name_button.setTitleColor(UIColor(155,155,155,1), for: .normal)
            name_button.setTitle("新习惯", for: .normal)
        } else {
            name_button.setTitleColor(UIColor(30,30,30,1), for: .normal)
            name_button.setTitle(value, for: .normal)
        }
    }
    
    // MARK: - Keyboard
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        update_name_button(value: value)
    }
    
}
