//
//  HabitFrequencyCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitFrequencyCard: StepCard {
    
    // MARK: - Data
    
    var unit: TimeUnit {
        if day.is_select {
            var v = [false, false, false, false, false, false, false]
            for b in day_buttons {
                v[b.tag] = b.is_select
            }
            return TimeUnit.day(v)
        } else if week.is_select {
            return TimeUnit.week(week_view.int)
        } else {
            return TimeUnit.month(month_view.int)
        }
    }
    
    // MARK: - Layout
    
    @IBOutlet weak var center_layout: NSLayoutConstraint!
    
    @IBOutlet weak var week_layer: NSLayoutConstraint!
    @IBOutlet weak var month_layer: NSLayoutConstraint!
    
    // MARK: - Date
    
    @IBOutlet weak var day: Button!
    @IBOutlet weak var week: Button!
    @IBOutlet weak var month: Button!
    
    @IBAction func date_action(_ sender: Button) {
        for (i, button) in [day, week, month].enumerated() {
            button?.is_select = button === sender
            if button === sender {
                switch i {
                case 0:
                    UIView.animate(withDuration: 0.25, animations: {
                        self.week_layer?.constant = 400
                        self.month_layer?.constant = 400
                        self.layoutIfNeeded()
                    })
                case 1:
                    UIView.animate(withDuration: 0.25, animations: {
                        self.week_layer?.constant = 0
                        self.month_layer?.constant = 400
                        self.layoutIfNeeded()
                    })
                case 2:
                    UIView.animate(withDuration: 0.25, animations: {
                        self.week_layer?.constant = 0
                        self.month_layer?.constant = 0
                        self.layoutIfNeeded()
                    })
                default: break
                }
            }
        }
    }
    
    // MARK: - Day
    
    @IBOutlet var day_buttons: [Button]!
    @IBAction func day_action(_ sender: Button) {
        sender.is_select = !sender.is_select
    }
    
    @IBOutlet var week_view: iSelector! {
        didSet {
            week_view.data = iSelector.numbser(s: 1, e: 30)
        }
    }
    @IBOutlet var month_view: iSelector! {
        didSet {
            month_view.data = iSelector.numbser(s: 1, e: 100)
        }
    }
    
    // MARK: - Animation
    
    func hide_animation(is_left: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            self.center_layout.constant = is_left ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width
            self.superview?.layoutIfNeeded()
        })
    }
    
    func show_animation() {
        UIView.animate(withDuration: 0.25, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.center_layout.constant = 0
            self.superview?.layoutIfNeeded()
        }, completion: { _ in })
    }
    
}
