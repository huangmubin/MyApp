//
//  HabitListController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Datas
    
    /**  */
    var doing: [Habit] = []
    /**  */
    var archive: [Habit] = []
    /**  */
    var is_doing: Bool { return !type_button.isSelected }
    
    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let objs = Habit.table_find()
        doing = objs.flatMap({ return $0.is_archive ? nil : $0 })
        archive = objs.flatMap({ return $0.is_archive ? $0 : nil })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let value = messages.removeValue(forKey: Keys.add.habit) as? Habit {
            if value.table_insert() {
                doing.append(value)
                if is_doing {
                    table.insertRows(at: [doing.index()], with: .bottom)
                }
            }
        }
        if let value = messages.removeValue(forKey: Keys.add.log) as? Habit.Log {
            if value.table_insert() {
                value.obj.logs.update_logs(date: value.date)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        doing.forEach({
            $0.logs.clear()
            $0.show.clear()
        })
        archive.forEach({
            $0.logs.clear()
            $0.show.clear()
        })
    }
    
    // MARK: - View
    
    // MARK: - View - Header
    
    @IBOutlet weak var type_button: UIButton!
    @IBAction func type_action() {
        type_button.isSelected = !type_button.isSelected
        table.reloadData()
    }
    
    // MARK: - View - Table
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return is_doing ? doing.count : archive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitListCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: "HabitShowController",
            sender: is_doing ? doing[indexPath.row] : archive[indexPath.row]
        )
    }
    
    // MARK: - View - Footer
    
    @IBAction func segue_add() {
        performSegue(withIdentifier: "HabitAddController", sender: nil)
    }
    
    @IBAction func segue_user() {
        performSegue(withIdentifier: "UserController", sender: nil)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let show = segue.destination as? HabitShowController, let value = sender as? Habit {
            show.habit = value
        }
    }
    
}
