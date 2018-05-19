//
//  LogListController.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogListController: ViewController, UITableViewDataSource, UITableViewDelegate {

    var habit: Habit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habit_label.text = habit.value.name
        habit.update_dates()
        habit.dates.sort(by: { $0 > $1 })
        
        table.register(UINib(nibName: "LogListHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        table.sectionHeaderHeight = 60
        table.rowHeight = UITableViewAutomaticDimension
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let log = messages.removeValue(forKey: "LogAdd") as? Log {
            log.value.id = SQLite.Log.new_id
            log.value.insert()
            habit.append(log: log, date: log.value.date)
            if let index = habit.dates.index(of: log.value.date) {
                table.reloadSections([index], with: .fade)
            } else {
                habit.dates.append(log.value.date)
                habit.dates.sort(by: { $0 > $1 })
                let i = habit.dates.index(of: log.value.date)!
                table.insertSections([i], with: .fade)
            }
        }
        if let log = messages.removeValue(forKey: "LogUpdate") as? Log {
            log.value.update()
            let s = habit.dates.index(of: log.value.date)!
            let r = habit.logs(date: log.value.date).index(where: { $0 === log })!
            table.reloadRows(at: [IndexPath(row: r, section: s)], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    @IBOutlet weak var name_button: UIButton!
    @IBOutlet weak var habit_label: UILabel!
    
    @IBAction func back_action(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table View
    
    @IBOutlet weak var table: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return habit.dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.logs(date: habit.dates[section]).count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! LogListHeader
        header.date = habit.dates[section]
        header.view_update(index: IndexPath(row: 0, section: section), controller: self)
        return header
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! LogListHeader
        header.date = habit.dates[section]
        header.view_update(index: IndexPath(row: 0, section: section), controller: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LogListCell
        cell.date = habit.dates[indexPath.section]
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: "Edit",
            sender: habit.logs(date: habit.dates[indexPath.section])[indexPath.row]
        )
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let date = habit.dates[indexPath.section]
            let log = habit.logs(remove: indexPath)
            log.value.delete()
            if habit.logs(date: date).count == 0 {
                habit.dates.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let log = segue.controller as? LogEditController {
            if segue.identifier == "Add" {
                log.log = Log(habit)
            }
            if segue.identifier == "Edit" {
                log.log = sender as! Log
            }
        }
    }
    
}
