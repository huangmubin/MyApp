//
//  HabitLogEditController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitLogEditController: ViewController {

    // MARK: - Data
    
    var habit: String = ""
    var log: HabitLog!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_label.text = habit
        date.date = Date(today: log.date) ?? Date()
        start.date = Date(timeIntervalSince1970: TimeInterval(log.start))
        end.date = Date(timeIntervalSince1970: TimeInterval(log.end))
        note.setTitle(log.note, for: .normal)
    }
    
    // MARK: - Name
    
    @IBOutlet weak var name_label: UILabel!
    
    // MARK: - Date
    
    @IBOutlet weak var date: iDateSelector!
    
    // MARK: - Time
    
    @IBOutlet weak var start: iDateSelector!
    @IBOutlet weak var end: iDateSelector!
    
    // MARK: - Note
    
    @IBOutlet weak var note: UIButton!
    @IBOutlet weak var note_view: UIView!
    
    @IBOutlet weak var width_layout: NSLayoutConstraint!
    @IBOutlet weak var bottom_layout: NSLayoutConstraint!
    @IBOutlet weak var text_view: UITextView!
    
    @IBOutlet weak var note_reset: UIButton!
    @IBOutlet weak var note_save: UIButton!
    
    @IBAction func note_action(_ sender: UIButton) {
        text_view.becomeFirstResponder()
    }
    @IBAction func note_reset_action(_ sender: UIButton) {
        text_view.resignFirstResponder()
    }
    @IBAction func note_save_action(_ sender: UIButton) {
        note.setTitle(text_view.text, for: .normal)
        text_view.resignFirstResponder()
    }
    
    override func keyboard_will_change_frame(keyboard rect: CGRect) {
        if rect.minY >= height {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottom_layout.constant = 100
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.note_reset.alpha = 0
                    self.note_save.alpha = 0
                    self.text_view.alpha = 0
                }, completion: { _ in
                    self.note_view.isHidden = false
                    self.note_reset.isHidden = true
                    self.note_save.isHidden = true
                    self.text_view.isHidden = true
                })
            })
        } else {
            self.text_view.text = self.note.title(for: .normal)
            self.note_reset.alpha = 0
            self.note_save.alpha = 0
            self.text_view.alpha = 1
            self.note_reset.isHidden = false
            self.note_save.isHidden = false
            self.text_view.isHidden = false
            self.note_view.isHidden = true
            UIView.animate(withDuration: 0.25, animations: {
                self.bottom_layout.constant = rect.height + 20
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.note_reset.alpha = 1
                    self.note_save.alpha = 1
                }, completion: nil)
            })
        }
    }
    
    // MARK: - Menu
    
    @IBAction func cancel_action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save_action(_ sender: UIButton) {
        let new = date.date
        log.start = Int(start.date(year: new.year, month: new.month, day: new.day, hour: nil, minut: nil).timeIntervalSince1970)
        log.end = Int(end.date(year: new.year, month: new.month, day: new.day, hour: nil, minut: nil).timeIntervalSince1970)
        log.note = note.title(for: .normal) ?? ""
        log.date = date.date.today
        if !log.table_update() { }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
