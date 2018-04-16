//
//  HabitAddController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitAddController: ViewController {

    /** Card space */
    @IBInspectable var layout_space: CGFloat = 1000
    
    // MARK: - View life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_center_layout.constant = 0
        frequency_center_layout.constant = layout_space
        duration_center_layout.constant = layout_space
    }

    // MARK: - Name
    
    @IBOutlet weak var name: HabitNameCard!
    @IBOutlet weak var name_bottom_layout: NSLayoutConstraint!
    @IBOutlet weak var name_center_layout: NSLayoutConstraint!
    
    @IBAction func name_close_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func name_next_action(_ sender: UIButton) {
        //print_f(text: "name = \(name.text_view.text)")
        name.text_view.resignFirstResponder()
        frequency.redeploy()
        move_animate(view: 1)
    }
    
    // MARK: - Frequency
    
    @IBOutlet weak var frequency: HabitFrequencyCard!
    @IBOutlet weak var frequency_center_layout: NSLayoutConstraint!
    
    @IBAction func frequency_close_action(_ sender: UIButton) {
        move_animate(view: 0)
    }
    
    @IBAction func frequency_next_action(_ sender: UIButton) {
        //print_f(text: "frequency = \(frequency.frequency.every) - \(frequency.frequency.times)")
        move_animate(view: 2)
    }
    
    // MARK: - Duration
    
    @IBOutlet weak var duration: HabitDurationCard!
    @IBOutlet weak var duration_center_layout: NSLayoutConstraint!
    
    @IBAction func duration_close_action(_ sender: UIButton) {
        move_animate(view: 1)
    }
    
    @IBAction func duration_next_action(_ sender: UIButton) {
        //print_f(text: "duration = \(duration.hour.index) - \(duration.minute.index) = \(duration.duration())")
        
        let habit = Habit()
        habit.name = name.text_view.text
        habit.timeunit = TimeUnit(value: frequency.frequency.every)
        habit.count = frequency.frequency.times
        habit.duration = duration.duration()
        
        toSuperController(object: [Habit.new: habit])
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Animation
    
    func move_animate(view: Int) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            switch view {
            case 0:
                self.name_center_layout.constant = 0
                self.frequency_center_layout.constant = self.layout_space
                self.duration_center_layout.constant = self.layout_space
            case 1:
                self.name_center_layout.constant = -self.layout_space
                self.frequency_center_layout.constant = 0
                self.duration_center_layout.constant = self.layout_space
            case 2:
                self.name_center_layout.constant = -self.layout_space
                self.frequency_center_layout.constant = -self.layout_space
                self.duration_center_layout.constant = 0
            default: break
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Keyboard
    
    override func keyboard_will_change_frame(keyboard rect: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            self.name_bottom_layout.constant = self.height - rect.minY + 20
            self.view.layoutIfNeeded()
        })
    }
}
