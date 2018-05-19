//
//  LogEditStatusCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditStatusCard: CardView {

    override func reload() {
        state_buttons.forEach({
            let type = ($0.tag == 1) == self.log.value.is_sick
            $0.backgroundColor = type ? self.log.habit.color() : Color.gray_light
            $0.setTitleColor(
                type ? Color.white : Color.dark,
                for: .normal
            )
        })
    }
    
    // MARK: - Buttons
    
    @IBOutlet var state_buttons: [Button]!
    
    @IBAction func state_action(_ sender: Button) {
        log.value.is_sick = (sender.tag == 1)
        reload()
    }

}
