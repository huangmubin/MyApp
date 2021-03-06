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
        self.navigationItem.title = habit.name
        card.controller = self
        card.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let log = messages.removeValue(forKey: "LogAdd") as? Habit.Log {
            if log.insert() {
                habit.cache.reload_logs(date: log.date)
                if let card = card.card(id: "Calendar") as? ShowCalendarCard {
                    card.calendar.days.reloadData()
                }
            }
        }
        if let log = messages.removeValue(forKey: "LogEdit") as? Habit.Log {
            if log.update() {
                habit.cache.reload_logs(date: log.date)
                if let card = card.card(id: "Calendar") as? ShowCalendarCard {
                    card.calendar.days.reloadData()
                }
            }
        }
    }
    
    // MARK: - Card
    
    /** 卡片集合 */
    @IBOutlet weak var card: CardTable!
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let log = segue.controller as? LogEditController {
            log.log = sender as! Habit.Log
        }
        if let logs = segue.controller as? LogListController {
            logs.date = sender as! Date
            logs.obj = habit
        }
        if let event = segue.controller as? EventListController {
            event.habit = habit
        }
    }
    
}
