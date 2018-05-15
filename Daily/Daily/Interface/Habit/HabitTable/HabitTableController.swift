//
//  HabitTableController.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitTableController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Datas
    
    /** 数据列表 */
    var habits: [Habit] = []
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = Habit.find()
        habits.forEach({ $0.cache.reload() })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 接收新建习惯消息，然后创建并保存。
        if let habit = messages.removeValue(forKey: "HabitAdd") as? Habit {
            if habit.insert() {
                habit.cache.reload()
                habits.append(habit)
                table.insertRows(at: [IndexPath(habits)], with: .automatic)
            }
        }
        if let log = messages.removeValue(forKey: "LogAdd") as? Habit.Log {
            if log.insert() {
                log.obj.cache.reload_logs(date: log.date)
                log.obj.cache.reload_length()
                if let index = habits.index(where: { $0 === log.obj }) {
                    table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitTableCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: "HabitShow",
            sender: habits[indexPath.row]
        )
    }
    
    // MARK: - Add
    
    @IBAction func add_new_habit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "HabitEdit", sender: nil)
    }
    
    // MAKR: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let show = segue.destination as? HabitShowController {
            show.habit = sender as! Habit
        }
        if let log = segue.controller as? LogEditController {
            log.log = sender as! Habit.Log
        }
        if let habit = segue.destination as? HabitEditController {
            habit.habit = Habit()
        }
    }
    
}
