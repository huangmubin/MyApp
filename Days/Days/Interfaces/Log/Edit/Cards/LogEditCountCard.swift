//
//  LogEditCountCard.swift
//  Days
//
//  Created by Myron on 2018/5/19.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditCountCard: CardView, KeyboardInputDelegate {

    override func reload() {
        count_button.setTitle("\(log.value.length)", for: .normal)
    }
    
    
    // MARK: - Count Button
    
    @IBOutlet weak var count_button: Button!
    
    @IBAction func count_action(_ sender: Any) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.title.text = "输入次数"
            view.input.text = "\(log.value.length)"
            view.input.keyboardType = .numberPad
            view.push()
        }
    }
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        log.value.length = max(1, Int(value)!)
        reload()
    }
    
    // MARK: - Offset
    
    @IBAction func decrease_action(_ sender: Any) {
        log.value.length = max(1, log.value.length - 1)
        reload()
    }
    
    @IBAction func increase_action(_ sender: Any) {
        log.value.length += 1
        reload()
    }
    
}
