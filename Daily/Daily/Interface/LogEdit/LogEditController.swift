//
//  LogEditController.swift
//  Daily
//
//  Created by Myron on 2018/5/8.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditController: BaseViewController {

    // MARK: - Data
    
    /** Habit Log */
    var log: Habit.Log!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {
//            self.navigationItem.title = self.log.obj.name
//            self.date.update(date: Date(self.log.date))
//            self.start.update(date: Date(time: self.log.start))
//            self.end.update(date: Date(time: self.log.end))
//            self.note.text = self.log.note
//        }
        cards.controller = self
        cards.reload()
    }
    
    // MARK: - preferredStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: - Card
    
    @IBOutlet weak var cards: CardTable!
    
    
    
    
    // MARK: - Save
    
    @IBAction func save_action(_ sender: UIBarButtonItem) {
        log.date = date.date().date
        log.start = start.date().time1970
        log.length = end.date().time1970 - log.start
        log.note = note.text
        if log.id == 0 {
            log.id = Habit.Log.new_id
            toSuperController(object: ["LogAdd": log])
        } else {
            toSuperController(object: ["LogEdit": log])
        }
        if navigationController == nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Date
    
    /**  */
    @IBOutlet weak var date: iDateSelector!
    
    // MARK: - Time
    
    /**  */
    @IBOutlet weak var start: iDateSelector!
    /**  */
    @IBOutlet weak var end: iDateSelector!
    
    // MARK: - note
    
    /**  */
    @IBOutlet weak var note: UITextView!
    
    
}
