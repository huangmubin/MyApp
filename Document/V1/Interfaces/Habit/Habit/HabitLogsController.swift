//
//  HabitLogsController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/27.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogsController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_label.text = habit.name
        logs = HabitLog.table_find(habit: habit.id).sorted(by: { $0.date > $1.date })
        
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewdidAppear = \(date)")
        for i in 0 ..< logs.count {
            if logs[i].date <= date {
                table.scrollToRow(at: IndexPath(row: i, section: 0), at: .top, animated: true)
                break
            }
        }
    }
    
    // MARK: - Layout
    
    @IBOutlet weak var top_layout: NSLayoutConstraint!
    
    // MARK: - Dates
    
    var habit: Habit!
    var date: Int = 0
    
    var logs: [HabitLog] = []
    
    // MARK: - Infos
    
    @IBOutlet weak var name_label: UILabel!
    
    // MARK: - Table View
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: Datesource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitLogsCell
        cell.update(log: logs[indexPath.row])
        return cell
    }
    
    // MARK: Scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.top_layout.constant = scrollView.contentOffset.y < 0 ? -scrollView.contentOffset.y + 20 : 20
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -100 {
            self.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HabitLogEditController {
            let i = table.indexPathForSelectedRow!.row
            controller.habit = habit.name
            controller.log = logs[i]
        }
    }
    
}
