//
//  LogListController.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogListController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Datas
    
    /** Habit */
    var obj: Habit!
    
    /** Show Date */
    var date: Date!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = UITableViewAutomaticDimension
        date_label.text = DateFormatter("yyyy 年 MM 月 dd 号").string(from: date)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let log = messages.removeValue(forKey: "LogEdit") as? Habit.Log {
            if log.update() {
                obj.cache.reload_logs(date: log.date)
                table.reloadData()
            }
        }
    }
    
    // MARK: - Date Label
    
    @IBOutlet weak var date_label: UILabel!
    
    // MARK: - List
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj.cache.logs(date.date).count
    }
    
    let format = DateFormatter("HH:mm")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LogListCell
        let log = obj.cache.logs(date.date)[indexPath.row]
        cell.time.text = "\(format.string(from: Date(time: log.start))) - \(format.string(from: Date(time: log.end)))"
        cell.length.text = "\(log.length / 60) 分钟"
        cell.note.text = log.note.isEmpty ? "无备注" : log.note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let log = obj.cache.logs(date.date)[indexPath.row]
        performSegue(withIdentifier: "LogEdit", sender: log)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let log = segue.destination as? LogEditController {
            log.log = sender as! Habit.Log
        }
    }
    
}
