//
//  HabitAddController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitAddController: ViewController {

    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_center.constant     = 0
        duration_center.constant = width
        message_center.constant  = width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        name.text.becomeFirstResponder()
    }
    
    // MARK: - Name
    
    @IBOutlet weak var name: HabitAddNameCard!
    @IBOutlet weak var name_center: NSLayoutConstraint!
    
    @IBAction func name_save_action(_ sender: UIButton) {
        animation_show_duration()
    }
    
    @IBAction func name_cancel_action(_ sender: UIButton) {
        dismiss(create: false)
    }
    
    // MARK: - Duration
    
    @IBOutlet weak var duration: HabitAddDurationCard!
    @IBOutlet weak var duration_center: NSLayoutConstraint!
    
    @IBAction func duration_save_action(_ sender: UIButton) {
        animation_show_message()
    }
    
    @IBAction func duration_cancel_action(_ sender: UIButton) {
        animation_show_name()
    }
    
    // MARK: - Message
    
    @IBOutlet weak var message: HabitAddMessageCard!
    @IBOutlet weak var message_center: NSLayoutConstraint!
    
    @IBAction func message_save_action(_ sender: UIButton) {
        dismiss(create: true)
    }
    
    @IBAction func message_cancel_action(_ sender: UIButton) {
        animation_show_duration()
    }
    
    // MARK: - Animations
    
    /**  */
    private func animation_show_name() {
        let delay: Double = 0
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveLinear, animations: {
            self.duration_center.constant = self.width
            self.message_center.constant = self.width
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
                self.name_center.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.name.text.becomeFirstResponder()
            })
        })
    }
    
    private func animation_show_duration() {
        let delay: Double = (message.text.isFirstResponder || name.text.isFirstResponder) ? 1 : 0
        name.text.resignFirstResponder()
        message.text.resignFirstResponder()
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveLinear, animations: {
            self.message_center.constant = self.width
            self.name_center.constant = -self.width
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
                self.duration_center.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { _ in })
        })
    }
    
    private func animation_show_message() {
        let delay: Double = 0
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveLinear, animations: {
            self.duration_center.constant = -self.width
            self.name_center.constant = -self.width
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
                self.message_center.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { _ in })
        })
    }
    
    // MARK: - Dismiss
    
    func dismiss(create: Bool) {
        if create {
            let habit = Habit()
            habit.id       = Habit.new_id
            habit.name     = name.name
            habit.duration = duration.time
            habit.message  = message.message
            habit.deploy_sub()
            toSuperController(object: [Keys.add.habit: habit])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
