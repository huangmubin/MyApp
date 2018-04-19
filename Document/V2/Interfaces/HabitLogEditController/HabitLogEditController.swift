//
//  HabitLogEditController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/6.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogEditController: ViewController, UITableViewDataSource {

    // MARK: - Data
    
    var log: Habit.Log!
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.estimatedRowHeight = 90
            table.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id: String = {
            switch indexPath.row {
            case 0: return "Name"
            case 1: return "Time"
            case 2: return log.is_absent ? "Reason" : "Note"
            default: return "Control"
            }
        }()
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! HabitLogCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    // MARK: - Name
    
    weak var name: HabitLogNameCell?
    
    // MARK: - Time
    
    weak var time: HabitLogTimeCell?
    
    // MARK: - Note
    
    weak var note: HabitLogNoteCell?
    
    // MARK: - Control
    
    weak var control: HabitLogControlCell?
    
    // MARK: - Action
    
    override func tableView(cell: TableViewCell, user action: String) {
        switch action {
        case Keys.control.save:
            let key = log.id == 0 ? Keys.add.log : Keys.update.log
            if log.id == 0 {
                log.id = log.new_id
            }
            log.start = time?.start.date(day: "\(log.date)") ?? log.start
            log.end = time?.end.date(day: "\(log.date)") ?? log.end
            if log.start >= log.end {
                if log.end.hour == 0 && log.end.minute == 0 {
                    log.end = log.end.advance(time: 86400)
                }
            }
            toSuperController(object: [key: log])
        case Keys.control.cancel:
            break
        case Keys.control.delete:
            toSuperController(object: [Keys.delete.log: log])
        default: break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
