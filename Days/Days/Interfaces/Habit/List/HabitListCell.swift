//
//  HabitListCell.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class MaskView: View {
    
    weak var base_view: UIView!
    
    override func view_bounds() {
        base_view.mask?.frame = self.bounds
    }
    
}

class HabitListCell: TableViewCell {

    var habit: Habit!
    var date: Date!
    
    // MARK: - Reload
    
    override func view_load() {
        let mask = View(frame: mask_view.bounds)
        mask.backgroundColor = UIColor.black
        mask.corner = base_view.corner
        base_view.mask = mask
        mask_view.base_view = base_view
        pan = UIPanGestureRecognizer(target: self, action: #selector(pan_action(_:)))
        pan.delegate = self
        addGestureRecognizer(pan)
    }
    
    override func view_reload() {
        image_view.image = habit.image()
        
        name.text = habit.value.name
        
        layout.constant = 0
        layoutIfNeeded()
        
        update_progress()
        
        let color = UIColor(habit.value.color)
        little.normal_color = color
        half.normal_color = color
        total.normal_color = color
        
        let step = habit.step()
        little.setTitle("\(step)", for: .normal)
        half.setTitle("\(step * 2)", for: .normal)
    }
    
    /** Update the progress views */
    func update_progress() {
        goal.text = habit.length_str(at_date: date.date)
        progress.text = "\(Int(habit.progress(at_date: date.date) * 100))%"
    }
    
    // MARK: - Image
    
    @IBOutlet weak var image_view: UIImageView!
    
    // MARK: - Infos
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var goal: UILabel!
    
    @IBOutlet weak var progress: UILabel!
    
    // MARK: - Control
    
    @IBOutlet weak var little: Button!
    
    @IBOutlet weak var half: Button!
    
    @IBOutlet weak var total: Button!
    
    func insert_log(time: Int) {
        let log = Log(habit)
        log.value.id = SQLite.Log.new_id
        log.value.start = Date().time1970 - time
        log.value.length = time
        log.value.insert()
        habit.append(log: log, date: date.date)
        update_progress()
        UIView.animate(withDuration: 0.2, animations: {
            self.base_view.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.base_view.alpha = 1
            })
        })
        UIView.animate(withDuration: 0.4, animations: {
            self.layout.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    @IBAction func little_action() {
        let time = habit.value.is_time ? habit.step() * 60 : habit.step()
        insert_log(time: time)
    }
    @IBAction func half_action() {
        let time = (habit.value.is_time ? habit.step() * 60 : habit.step()) * 2
        insert_log(time: time)
    }
    @IBAction func total_action() {
        let time = habit.value.length - habit.length(at_date: date.date)
        if time > 0 {
            insert_log(time: time)
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.layout.constant = 0
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Views
    
    /** base's mask */
    @IBOutlet weak var mask_view: MaskView!
    /** base container view */
    @IBOutlet weak var base_view: View!
    /** menu container view */
    @IBOutlet weak var menu_view: UIView!
    /** base - menu space */
    @IBOutlet weak var layout: NSLayoutConstraint!
    
    // MARK: - Gesture
    
    var pan: UIPanGestureRecognizer!
    var pan_start: CGFloat = 0
    @objc func pan_action(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            pan_start = self.layout.constant
        case .ended:
            if menu_view.frame.minX < self.frame.midX {
                UIView.animate(withDuration: 0.25, animations: {
                    self.layout.constant = self.menu_view.frame.width
                    self.layoutIfNeeded()
                })
            } else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.layout.constant = 0
                    self.layoutIfNeeded()
                })
            }
        default:
            let x = sender.translation(in: self).x
            self.layout.constant = min((-x + pan_start), self.menu_view.frame.width)
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === pan {
            let offset = pan.velocity(in: self)
            return abs(offset.x) > abs(offset.y)
        }
        return false
    }
    
}
