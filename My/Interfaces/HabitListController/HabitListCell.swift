//
//  HabitListCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitListCell: TableViewCell {
    
    var list: HabitListController { return controller as! HabitListController }
    var obj: Habit {
        if list.is_doing {
            return list.doing[index.row]
        } else {
            return list.archive[index.row]
        }
    }
    
    // MARK: - Deploy
    
    override func view_load() {
        pan = UIPanGestureRecognizer(target: self, action: #selector(pan_action(_:)))
        pan.delegate = self
        addGestureRecognizer(pan)
    }
    
    override func view_reload() {
        progress.setTitle(
            "\(obj.logs.logs(Date().today).count)",
            for: .normal
        )
    }
    
    // MARK: - Name
    
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Progress
    
    @IBOutlet weak var progress: UIButton!
    @IBAction func check_in_aciton(_ sender: UIButton) {
        let log = Habit.Log(obj)
        if log.table_insert() {
            obj.logs.update_logs(date: Date().today)
            view_reload()
        }
    }
    
    // MARK: - Gesture
    
    @IBOutlet weak var center_layout: NSLayoutConstraint!
    var pan: UIPanGestureRecognizer!
    
    @objc func pan_action(_ sender: UIPanGestureRecognizer) {
        let size = (self.bounds.width - 40) / 4
        switch pan.state {
        case .changed:
            let offset = pan.translation(in: self)
            center_layout.constant = Animation.ease_out_sin(c: offset.x / 2, max: size * 2)
        case .ended:
            let offset = center_layout.constant
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.center_layout.constant = 0
                self.layoutIfNeeded()
            }, completion: { _ in
                if offset >= size {
                    let log = Habit.Log(create: self.obj, absent: true)
                    self.list.performSegue(withIdentifier: "HabitLogEditController", sender: log)
                } else if offset <= -size {
                    let log = Habit.Log(create: self.obj, absent: false)
                    self.list.performSegue(withIdentifier: "HabitLogEditController", sender: log)
                }
            })
        default: break
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == pan {
            let offset = pan.translation(in: self)
            return abs(offset.x) > abs(offset.y)
        } else {
            return false
        }
    }
}
