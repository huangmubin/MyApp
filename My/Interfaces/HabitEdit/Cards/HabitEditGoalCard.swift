//
//  HabitEditGoalCard.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditGoalCard: HabitEditCard {
    
    // MARK: - Values
    
    /**  */
    var is_time: Bool { return centerX.constant == 0 }
    
    /** */
    var all: Int {
        if is_time {
            return Int(time_all.input.text ?? "0")!
        } else {
            return Int(count_all.input.text ?? "0")!
        }
    }
    
    /**  */
    var once: Int {
        if is_time {
            return Int(time_once.input.text ?? "0")!
        } else {
            return Int(count_once.input.text ?? "0")!
        }
    }
    
    
    // MARK: - Init
    
    override func reload() {
        if edit.habit.is_time {
            animate(to_count: false)
            time_all.input.text   = "\(edit.habit.goal)"
            time_once.input.text  = "\(edit.habit.length)"
            count_all.input.text  = "10000"
            count_once.input.text = "1"
        } else {
            animate(to_count: true)
            time_all.input.text   = "10000"
            time_once.input.text  = "10"
            count_all.input.text  = "\(edit.habit.goal)"
            count_once.input.text = "\(edit.habit.length)"
        }
    }
    
    // MARK: - View
    
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var container: View!
    
    // MARK: - Hour
    
    @IBOutlet weak var time_all: VarlenaInput!
    @IBOutlet weak var time_once: VarlenaInput!
    
    @IBAction func times_action(_ sender: UIButton) {
        animate(to_count: true)
    }
    
    // MARK: - Times
    
    @IBOutlet weak var count_all: VarlenaInput!
    @IBOutlet weak var count_once: VarlenaInput!
    
    @IBAction func counts_action(_ sender: UIButton) {
        animate(to_count: false)
    }
    
    // MARK: - Animate
    
    /** 动画效果 */
    func animate(to_count: Bool) {
        container.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.centerX.constant = (to_count ? -self.bounds.width : 0)
            self.layoutIfNeeded()
        }, completion: { _ in
            self.container.isUserInteractionEnabled = true
        })
    }
    
}
