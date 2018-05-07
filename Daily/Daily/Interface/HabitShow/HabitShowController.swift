//
//  HabitShowController.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowController: BaseViewController {

    // MARK: - Datas
    
    /** 习惯，从上层视图传递过来。 */
    var habit: Habit!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.controller = self
        card.reload()
    }
    
    // MARK: - Card
    
    /** 卡片集合 */
    @IBOutlet weak var card: CardTable!

}
