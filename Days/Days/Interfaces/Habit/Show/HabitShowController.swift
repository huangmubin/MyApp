//
//  HabitShowController.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension CardView {
    
    var date: Date {
        get {
            return (table.controller as! HabitShowController).date
        }
        set {
            (table.controller as! HabitShowController).date = newValue
        }
    }
    
}

class HabitShowController: ViewController, HabitObject {

    var habit: Habit!
    var date: Date = Date()

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
