//
//  Card.swift
//  Days
//
//  Created by Myron on 2018/5/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class Card {
    
    /** Sqlite Value Date */
    let value: SQLite.Card
    
    weak var habit: Habit!
    
    // MARK: - Init
    
    init(_ value: SQLite.Card) {
        self.value = value
    }
    
    init() {
        self.value = SQLite.Card()
    }
    
    
    // MARK: - Type
    
    enum CardType: Int {
        case date = 0
        case check = 1
        case chart = 2
        case event = 3
        case diary = 4
        case chart_log = 21
    }
    
    /** 获取 Card 类型 */
    var type: CardType {
        set { value.type = newValue.rawValue }
        get { return CardType(rawValue: value.type)! }
    }
    
    // MARK: - Image
    
    var image: UIImage {
        return UIImage(named: "card_image_\(value.type)")!
    }
    
    // MARK: - Cards
    
    /** 创建默认的卡片 */
    func cards_create() {
        for data in [
            ("日期选择", "显示并日期，让其他与时间有关的卡片可以进行时间轴定位。", 0),
            ("打卡按钮", "请假，打卡，或查看你的所有打卡记录。", 1),
            ("记录图表", "显示你每日的打卡记录时长或次数，让你最直观的看到自己最近一段时间是否达成。", 21),
            ("里程碑", "将你的习惯分成一个个小目标，让自己不断达成，保持干劲。", 3),
            ("日记", "用文字记录下这个习惯的经历，成为自己终身的记忆。", 4)
            ] {
                let card = SQLite.Card()
                card.id = SQLite.Card.new_id
                card.habit = value.id
                card.sort = card.id
                card.name = data.0
                card.note = data.1
                card.type = data.2
                let _ = card.insert()
        }
    }
    
}
