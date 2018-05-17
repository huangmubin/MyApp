//
//  HabitShowController.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowController: ViewController, HabitObject {

    var habit: Habit!

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.controller = self
        cards.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let habit = messages.removeValue(forKey: "HabitUpdate") as? Habit {
            habit.value.update()
        }
    }
    
    // MARK: - Card
    
    @IBOutlet weak var cards: CardTable!
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.controller as? HabitEditController {
            edit.habit = habit
        }
    }
    
}
