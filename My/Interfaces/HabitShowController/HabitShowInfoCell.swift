//
//  HabitShowInfoCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitShowInfoCell: HabitShowCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    // MARK: Deploy
    
    override func view_load() {
        name.text     = obj.name
        count.text    = "总计 \(obj.total_counts) 次"
        duration.text = "投入 \(obj.total_durations) 分钟"
    }
    
    // MARK: Action
    
    @IBOutlet weak var today: UIButton!
    @IBAction func check_action() {
        
    }

    
    
}
