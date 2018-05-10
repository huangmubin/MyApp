//
//  EventListController.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventListController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Date
    
    /** Habit */
    var habit: Habit!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = habit.name
        update_heights()
    }
    
    // MARK: - Height
    
    @IBOutlet weak var height_name_label: UILabel!
    @IBOutlet weak var height_note_label: UILabel!
    
    var heights: [CGFloat] = []
    
    /** 更新高度 */
    func update_heights() {
        heights.removeAll()
        let name_size = CGSize(width: UIScreen.main.bounds.width - 82, height: 500)
        let note_size = CGSize(width: UIScreen.main.bounds.width - 108, height: 500)
        height_name_label.frame.size = name_size
        height_note_label.frame.size = note_size
        for event in habit.cache.events {
            height_name_label.text = event.name
            height_note_label.text = event.note
            
            heights.append(
                height_name_label.sizeThatFits(name_size).height + height_note_label.sizeThatFits(note_size).height + 20 + 4
            )
        }
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habit.cache.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventListCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        text_input.resignFirstResponder()
    }
    
    // MARK: - Append
    
    @IBOutlet weak var layout_height: NSLayoutConstraint!
    @IBOutlet weak var layout_bottom: NSLayoutConstraint!
    
    @IBOutlet weak var text_input: UITextField!
    
    @IBAction func append_action(_ sender: UIButton) {
        if text_input.text?.isEmpty == false {
            let event = Habit.Event(habit)
            event.name = text_input.text!
            event.id = Habit.Event.new_id
            if event.insert() {
                habit.cache.events.append(event)
                update_heights()
                table.insertRows(
                    at: [IndexPath(habit.cache.events)],
                    with: .automatic
                )
            }
        }
        text_input.text = ""
    }
    
    // MARK: - Keyboard
    
    override func keyboard_will_change_frame(keyboard rect: CGRect) {
        if rect.minY < UIScreen.main.bounds.height {
            UIView.animate(withDuration: 0.25, animations: {
                self.layout_height.constant = 120
                self.layout_bottom.constant = -rect.height + (self.tabBarController?.tabBar.frame.height ?? 0)
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.layout_height.constant = 40
                self.layout_bottom.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
