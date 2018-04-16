//
//  HabitLogNameCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogNameCell: HabitLogCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func view_load() {
        log.name = self
        name.text = log.log.obj.name
        date.text = log.log.start.string(format: "yyyy 年 MM 月 dd 号")
    }

}
