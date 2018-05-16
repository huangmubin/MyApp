//
//  HabitEditUICard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditUICard: CardView {

    @IBOutlet weak var image: Button!
    
    @IBOutlet weak var color: Button!
    
    @IBAction func image_action(_ sender: Button) {
    }
    
    @IBAction func color_action(_ sender: Button) {
        table.controller?.performSegue(
            withIdentifier: "Color",
            sender: nil
        )
    }
    
}
