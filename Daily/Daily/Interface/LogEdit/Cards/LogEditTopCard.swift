//
//  LogEditTopCard.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditTopCard: LogEditCard {

    // MARK: - Name
    
    /** Habit name */
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Actions
    
    @IBAction func error_action(_ sender: UIButton) {
        edit.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func success_action(_ sender: UIButton) {
        if log.id == 0 {
            log.id = Habit.Log.new_id
            edit.toSuperController(object: ["LogAdd": log])
        } else {
            edit.toSuperController(object: ["LogEdit": log])
        }
        edit.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Reload
    
    override func reload() {
        name.text = log.obj.name
    }
    
}
