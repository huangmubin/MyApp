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

    // MARK: - Message
    
    /** 留言 */
    @IBOutlet weak var message: UILabel!
    
    // MARK: - Check Action
    
    /** Check in label */
    @IBOutlet weak var check_label: UILabel!
    /** Check in Button */
    @IBOutlet weak var check_button: UIButton!
    
    /** Check in Action */
    @IBAction func check_action() {
        controller?.performSegue(
            withIdentifier: "LogEdit",
            sender: Habit.Log(obj)
        )
    }
    
    // MARK: - Complete
    
    @IBOutlet weak var complete: UILabel!
    
    // MARK: - Reload
    
    override func view_reload() {
        name.text = obj.name
        message.text = obj.message
        complete.text = "\(obj.cache.length) / \(obj.goal)"
    }
    
}
