//
//  HabitEditDiaryCard.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditDiaryCard: HabitEditCard {

    override func reload() {
        
    }
    
    @IBOutlet weak var label: UILabel!
    
    func update(label: String) {
        self.label.text = label
        let h = max(self.label.sizeThatFits(CGSize(width: bounds.width, height: 42)).height, 42)
        self.frame.size.height = h + 48
        table.update_content_size()
    }

}
