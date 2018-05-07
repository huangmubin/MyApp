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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 接收新建习惯消息，然后创建并保存。
        if let habit = messages.removeValue(forKey: "HabitAdd") as? Habit {
            if habit.insert() {
                habits.append(habit)
                table.insertRows(at: [IndexPath(habits)], with: .automatic)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitTableCell", for: indexPath) as! HabitTableCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: "HabitShowController",
            sender: habits[indexPath.row]
        )
    }
    
    // MAKR: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let show = segue.destination as? HabitShowController {
            show.habit = sender as! Habit
        }
    }
    
}
