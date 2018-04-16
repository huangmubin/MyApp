//
//  HabitFrequencyCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitFrequencyCard: Card {
    
    @IBOutlet weak var frequency: Frequency!
    
    func redeploy() {
        if let button = frequency.day_button {
            frequency?.every_action(button)
        }
    }
    
}
