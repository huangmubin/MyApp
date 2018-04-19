//
//  HabitShowController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitShowController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Data
    
    var habit: Habit!
    
    // MARK: - View Life
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.show.flags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habit.show.cell(table: tableView, index: indexPath)
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return habit.show.height(indexPath)
    }
    
    // MARK: - Dismiss
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -200 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
