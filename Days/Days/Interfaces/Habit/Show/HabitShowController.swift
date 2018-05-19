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
        if let log = messages.removeValue(forKey: "LogAdd") as? Log {
            log.value.id = SQLite.Log.new_id
            log.value.insert()
            habit.append(log: log, date: log.value.date)
        }
        if let log = messages.removeValue(forKey: "LogUpdate") as? Log {
            log.value.update()
        }
        cards.reload()
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
            //print("<Segue> ShowController Open LogEditController, id = \(String(describing: segue.identifier)); log.date = \(edit.log.value.date); log.date_s \(edit.log.value.date_s);")
            //print("date = \(date); time = \(date.time1970); Date = \(Date().time)")
        }
        if let edit = segue.controller as? LogListController {
            edit.habit = habit
        }
    }
    
}
