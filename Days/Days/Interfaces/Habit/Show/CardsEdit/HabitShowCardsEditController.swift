//
//  HabitShowCardsEditController.swift
//  Days
//
//  Created by Myron on 2018/5/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowCardsEditController: ViewController, UITableViewDataSource, UITableViewDelegate {

    var habit: Habit!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_label.text = habit.value.name
        
        table.register(UINib(nibName: "HabitShowCardEditHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        table.sectionHeaderHeight = 80
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        table.isEditing = true
    }
    
    // MARK: - Navigation
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBAction func back_action(_ sender: UIButton) {
    }
    
    @IBAction func success_action(_ sender: UIButton) {
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitShowCardsEditCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! HabitShowCardEditHeader
        view.title.text = section == 0 ? "当前卡片" : "添加卡片"
        return view
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return indexPath.row % 2 == 0 ? UITableViewCellEditingStyle.none : UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}
