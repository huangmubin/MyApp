//
//  HabitAddController.swift
//  Daily
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitAddController: TableViewController {
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        name.becomeFirstResponder()
    }
    
    // MARK: - Save
    
    /** 创建新的习惯并发送给商层的视图控制器 */
    @IBAction func save_action(_ sender: UIBarButtonItem) {
        let habit: Habit = Habit(new: true)
        habit.name = name.text
        habit.goal = Int(goal.text!) ?? 1000
        habit.length = Int(length.text!) ?? 10
        habit.id = Habit.new_id
        toSuperController(object: ["HabitAdd": habit])
        if navigationController == nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Name
    
    /** 名称 */
    @IBOutlet weak var name: UITextView!
    
    // MARK: - Time
    
    /** 总目标 */
    @IBOutlet weak var goal: UITextField!
    
    /** 单词长度 */
    @IBOutlet weak var length: UITextField!
    
    // MARK: - Message
    
    /** 留言 */
    @IBOutlet weak var message: UITextView!
}
