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
    var date: Int = 0
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: - List
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj.cache.logs(date).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LogListCell
        let log = obj.cache.logs(date)[indexPath.row]
        cell.time.text = "\(Date(time: log.start))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let log = obj.cache.logs(date)[indexPath.row]
        performSegue(withIdentifier: "LogEditController", sender: log)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let log = segue.destination as? LogEditController {
            log.log = sender as! Habit.Log
        }
    }
    
}
