//
//  HabitListController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - View life
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload_object()
        reload_idles()
        reload_today()
        table.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let obj = messages.removeValue(forKey: Habit.new) as? Habit {
            add_object(obj: obj)
        }
    }
    
    // MARK: - Object Actions
    
    var habits: [Habit] = []
    
    func add_object(obj: Habit) {
        /** Habit insert */
        if obj.table_insert() {
            habits.append(obj)
            let index = IndexPath(row: habits.count - 1, section: 0)
            // print_f(text: "habits = \(habits.count); index = \(index)")
            table.insertRows(at: [index], with: .bottom)
        }
        
        /* 文件管理方式保持 Habit, 需要让 Habit 遵守 Json_Protocol
        if habit_files.save(obj.id.description, obj) {
            habits.append(obj)
            let index = IndexPath(row: habits.count - 1, section: 0)
            print_f(text: "habits = \(habits.count); index = \(index)")
            table.insertRows(at: [index], with: .bottom)
        }
         */
    }
    
    func reload_object() {
        habits = Habit.table_find()
        /* 文件管理方式保持 Habit, 需要让 Habit 遵守 Json_Protocol
        habits = habit_files.objects().flatMap({ Habit.json($0) })
        table.reloadData()
         */
    }
    
    /** update the habits's is_today_done */
    func reload_today() {
        habits.forEach({
            $0.cycle(date: Date())
            $0.cycle_logs_update()
        })
    }

    // MARK: - idles
    
    var idles: [Habit] = []
    
    func reload_idles() {
        idles = Habit.table_find_idle()
    }
    
    // MARK: - Type
    
    var type: HabitType = .normal
    
    @IBAction func normal_action(_ sender: UIButton) {
        type = .normal
        table.reloadData()
    }
    
    @IBAction func idle_action(_ sender: UIButton) {
        type = .idle
        table.reloadData()
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.tableFooterView = UIView()
        }
    }
    
    // MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .normal:
            return habits.count
        case .idle:
            return idles.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitListCell
        var obj: Habit
        switch type {
        case .normal:
            obj = habits[indexPath.row]
        case .idle:
            obj = idles[indexPath.row]
        }
        tableViewCell(update: cell, index: indexPath, obj: obj)
        return cell
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewCell(update: cell as! HabitListCell, index: indexPath, obj: habits[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: Update
    
    func tableViewCell(update cell: HabitListCell, index: IndexPath, obj: Habit) {
        cell.name.text = obj.name
        cell.info.text = obj.infos()
        
        cell.index = index
        cell.controller = self
        
        cell.check.setTitle(obj.cycle_done ? "D" : "C", for: .normal)
    }
    
    // MARK: Cell Action
    
    override func tableView(cell: TableViewCell, user action: String) {
        super.tableView(cell: cell, user: action)
        if action == HabitListCell.check {
            let obj = habits[cell.index.row]
            /*
            /** HabitLog insert */
            let log = HabitLog()
            log.habit = obj.id
            log.date = Date().today
            log.start = obj.start()
            log.end = log.start + obj.duration
            log.id = log.table_insert()
             */
            let log = HabitLog(habit: obj)
            /** Habit update */
            if log.id != -1 {
                obj.log_counts += 1
                obj.log_duration += log.duration
                if obj.table_update_log() {
                    obj.cycle_logs += 1
                    let cell = cell as! HabitListCell
                    tableViewCell(update: cell, index: cell.index, obj: obj)
                } else {
                    obj.log_counts -= 1
                    obj.log_duration -= log.duration
                }
            }
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HabitController,
            let index = table.indexPathForSelectedRow {
            switch type {
            case .normal:
                controller.show = HabitShow(habit: habits[index.row])
            case .idle:
                controller.show = HabitShow(habit: idles[index.row])
            }
        }
    }
    
}
