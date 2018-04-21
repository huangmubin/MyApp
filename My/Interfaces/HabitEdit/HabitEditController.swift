//
//  HabitAddController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditController: ViewController {
    
    // MARK: - Value
    
    var habit: Habit!
    
    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for id in (habit.is_new ? HabitEditController.new : HabitEditController.eidt) {
            let card = TableCards.Cards()
            card.identifier = id
            card.height = height(id: id)
            table.cards.append(card)
        }
        table.dataSource = table
        table.delegate = table
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: TableCards!
    
}

// MARK: - Identifiers

extension HabitEditController {
    
    /** 编辑状态下的 Cards */
    static let eidt: [String] = [
        "HabitEditNameCell",
        "HabitEditStartCell",
        "HabitEditTypeCell",
        "HabitEditMessageCell",
        "HabitEditLogCell",
        "HabitEditControlCell",
    ]
    
    /** 新建状态下的 Cards */
    static let new: [String] = [
        "HabitEditNameCell",
        "HabitEditStartCell",
        "HabitEditTypeCell",
        "HabitEditMessageCell",
    ]
    
}

// MARK: - Heights

extension HabitEditController {
    
    /** 计算单元格的高度规则 */
    func height(id: String) -> CGFloat {
        switch id {
        case "HabitEditNameCell": break
        case "HabitEditStartCell": break
        case "HabitEditTypeCell": break
        case "HabitEditMessageCell": break
        case "HabitEditLogCell": break
        case "HabitEditControlCell": break
        default: break
        }
        return 0
    }
    
}
