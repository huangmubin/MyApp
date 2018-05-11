//
//  ShowNameCard.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ShowNameCard: HabitShowCard {

    // MARK: - Views
    
    /** Name */
    @IBOutlet weak var name: UILabel!

    // MARK: - Reload
    
    override func reload() {
        name.text = obj.name
    }
    
}
