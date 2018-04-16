//
//  HabitListCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/14.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListCell: TableViewCell {
    
    static let check: String = "HabitListCell_Check"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var check: UIButton!
    @IBAction func check_action(_ sender: UIButton) {
        controller?.tableView(cell: self, user: HabitListCell.check)
    }
    
}
