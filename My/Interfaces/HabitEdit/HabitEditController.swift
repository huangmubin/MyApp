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
    
    /** */
    var habit: Habit!
    
    // MARK: - View Life
    
    /**  */
    override func viewDidLoad() {
        super.viewDidLoad()
        table.controller = self
        table.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let name = table.cards.find(condition: { $0 is HabitEditNameCard }) as? HabitEditNameCard {
            name.text.becomeFirstResponder()
        }
    }
    
    // MARK: - Card Table
    
    /** Card Table */
    @IBOutlet weak var table: CardTable!
}
