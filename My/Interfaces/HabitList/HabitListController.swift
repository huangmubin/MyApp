//
//  HabitListController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Datas
    
    var habits: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = Habit.find(where: "state = 0")
        
        for (i, n) in ["英语学习", "编程开发", "运动健身", "Python学习", "游戏娱乐", "陪伴家人"].enumerated() {
            let habit = Habit(new: true)
            habit.name = n
            habit.id = i
            habit.message = "加油！！！"
            habit.goal = 10000
            habits.append(habit)
        }
    }
    
    // MARK: - Table View
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitListCell
        cell.habit = habits[indexPath.row]
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HabitShow", sender: habits[indexPath.row])
    }
    
    // MARK: - Menu
    
    @IBAction func add(_ sender: UIButton) {
        performSegue(withIdentifier: "HabitAdd", sender: nil)
    }
    
    @IBAction func idle(_ sender: UIButton) {
        performSegue(withIdentifier: "HabitIdle", sender: nil)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "HabitAdd":
            if let destination = segue.controller as? HabitEditController {
                destination.habit = Habit(new: true)
            }
        default:
            break
        }
    }
    
}
