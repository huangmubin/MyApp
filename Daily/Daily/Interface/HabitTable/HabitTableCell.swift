//
//  HabitTableCell.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** 习惯列表显示单元 */
class HabitTableCell: TableViewCell {

    // MARK: - Data
    
    /** 获取数据 */
    var obj: Habit {
        return (controller as! HabitTableController).habits[index.row]
    }
    
    // MARK: - Name
    
    /** 名称 */
    @IBOutlet weak var name: UILabel!

    // MARK: - Reload
    
    override func view_reload() {
        name.text = obj.name
    }
    
}
