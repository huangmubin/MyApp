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
        cards.cards.sort(by: { $0.index < $1.index })
        cards.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let habit = messages.removeValue(forKey: "HabitUpdate") as? Habit {
            habit.value.update()
            cards.reload()
        }
        if let log = messages.removeValue(forKey: "LogAdd") as? Log {
            log.value.id = SQLite.Log.new_id
            log.value.insert()
            habit.append(log: log, date: log.value.date)
            cards.reload()
        }
        if let log = messages.removeValue(forKey: "LogUpdate") as? Log {
            log.value.update()
            cards.reload()
        }
    }
    
    // MARK: - Card
    
    @IBOutlet weak var cards: CardTable!
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.controller as? HabitEditController {
            edit.habit = habit
        }
        if let edit = segue.controller as? LogEditController {
            edit.log = Log(habit)
            edit.log.value.date = date.date
            edit.log.value.start = date.first(.day).time1970 + Date().time
            edit.log.value.is_sick = (segue.identifier == "Sick")
        }
        if let edit = segue.controller as? LogListController {
            edit.habit = habit
        }
    }
    
}
