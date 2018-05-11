//
//  EventListController.swift
//  Daily
//
//  Created by Myron on 2018/5/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class EventListController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    // MARK: - Date
    
    /** Habit */
    var habit: Habit!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_label.text = habit.name
        update_heights()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let event = messages.removeValue(forKey: "EventEdit") as? Habit.Event {
            if event.update() {
                if let index = habit.cache.events.index(where: { $0 === event }) {
                    update_height(index: index)
                    table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    // MARK: - Navigation
    
    /** Navigation name label */
    @IBOutlet weak var name_label: UILabel!
    
    /** Navigation return action */
    @IBAction func return_action() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /** Navigation edit action */
    @IBAction func edit_action() {
        table.isEditing = !table.isEditing
    }
    
    // MARK: - Height
    
    @IBOutlet weak var height_name_label: UILabel!
    @IBOutlet weak var height_note_label: UILabel!
    
    var heights: [CGFloat] = []
    
    /** 更新高度 */
    func update_heights() {
        heights.removeAll()
        let name_size = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        let note_size = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        height_name_label.frame.size = name_size
        height_note_label.frame.size = note_size
        for event in habit.cache.events {
            height_name_label.text = event.name
            height_note_label.text = event.note
            heights.append(
                height_name_label.sizeThatFits(name_size).height + height_note_label.sizeThatFits(note_size).height + 8 + 2
            )
        }
    }
    
    /** 更新某一个高度 */
    func update_height(index: Int) {
        let name_size = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        let note_size = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        height_name_label.frame.size = name_size
        height_note_label.frame.size = note_size
        height_name_label.text = habit.cache.events[index].name
        height_note_label.text = habit.cache.events[index].note
        heights[index] = height_name_label.sizeThatFits(name_size).height + height_note_label.sizeThatFits(note_size).height + 8 + 2
    }
    
    // MARK: - Table
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return table.isEditing
    }
    
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
    
    // MARK: - Edit
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if habit.cache.events[indexPath.row].delete() {
                habit.cache.events.remove(at: indexPath.row)
                heights.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        habit.cache.events.move(source: sourceIndexPath.row, destination: destinationIndexPath.row)
        heights.move(source: sourceIndexPath.row, destination: destinationIndexPath.row)
        var sorts = [Int]()
        let l = min(sourceIndexPath.row, destinationIndexPath.row)
        let r = max(sourceIndexPath.row, destinationIndexPath.row)
        for i in l ... r {
            sorts.append(habit.cache.events[i].sort)
        }
        sorts.sort()
        for (i, sort) in sorts.enumerated() {
            habit.cache.events[i+l].sort = sort
            habit.cache.events[i+l].update("sort = \(sort)")
        }
    }
    
    // MARK: - Append
    
    @IBOutlet weak var layout_bottom: NSLayoutConstraint!
    @IBOutlet weak var text_input: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if text_input.text?.isEmpty == false {
            let event = Habit.Event(habit)
            event.name = text_input.text!
            event.id = Habit.Event.new_id
            event.sort = event.id
            if event.insert() {
                habit.cache.events.append(event)
                update_heights()
                UIView.animate(withDuration: 0.25, animations: {
                    self.table.contentOffset.y += self.heights.last!
                })
                table.insertRows(
                    at: [IndexPath(habit.cache.events)],
                    with: .bottom
                )
            }
        }
        text_input.text = ""
        return true
    }
    
    // MARK: - Keyboard
    
    override func keyboard_will_change_frame(keyboard rect: CGRect) {
        if rect.minY < UIScreen.main.bounds.height {
            let tabbar = CGFloat(0)
            let bottom = rect.height - tabbar + 40
            UIView.animate(withDuration: 0.25, animations: {
                self.table.contentInset.bottom = bottom
                self.table.contentOffset.y = max(self.table.contentSize.height - (self.table.bounds.height - bottom), 0)
                self.layout_bottom.constant = -rect.height + tabbar
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.table.contentInset.bottom = 0
                self.layout_bottom.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Segue
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventEdit", sender: habit.cache.events[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let event = segue.controller as? EventEditController {
            event.event = sender as! Habit.Event
        }
    }
}
