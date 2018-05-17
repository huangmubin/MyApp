//
//  HabitEditUICard.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditUICard: CardView {

    /**  */
    override func reload() {
        self.image.setImage(
            ImageController.image(
                name: habit.value.image,
                color: habit.value.color
            ),
            for: .normal
        )
        color.normal_color = UIColor(UInt(habit.value.color))
    }
    
    // MARK: - Buttons
    
    /**  */
    @IBOutlet weak var image: UIButton!
    /**  */
    @IBOutlet weak var color: Button!
    
    /**  */
    @IBAction func image_action(_ sender: Button) {
        table.controller?.performSegue(
            withIdentifier: "Image",
            sender: nil
        )
    }
    
    /**  */
    @IBAction func color_action(_ sender: Button) {
        table.controller?.performSegue(
            withIdentifier: "Color",
            sender: nil
        )
    }
    
}
