//
//  EventEdtiController.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventEditController: BaseViewController {

    // MARK: - Data
    
    var event: Habit.Event!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.controller = self
        cards.reload()
    }
    
    // MARK: - Card
    
    @IBOutlet weak var cards: CardTable!
    
}
