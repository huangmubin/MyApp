//
//  HabitListController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitListController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Data
    
    var habits: [Habit] = []
    var date: Date = Date()
    
    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = SQLite.Habit.find().map({ return Habit($0) })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let habit = messages.removeValue(forKey: "HabitAdd") as? Habit {
            habit.value.id = SQLite.Habit.new_id
            habit.value.insert()
            habits.append(habit)
            table.insertRows(at: [IndexPath(habits)], with: .bottom)
        }
    }
    
    // MARK: - UITableView
    
    @IBOutlet weak var table: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return habits.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitListCell
        cell.date = date
        cell.habit = habits[indexPath.row]
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "HabitShow", sender: self.habits[indexPath.row])
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.controller as? HabitEditController {
            edit.habit = Habit()
        }
        if let show = segue.controller as? HabitShowController {
            show.habit = sender as! Habit
        }
    }
    
}

