//
//  LogEditTopCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditTopCard: CardTopView {
    
    
    
    override func reload() {
        title.text = log.value.id == 0 ? "新增记录" : "编辑记录"
        name.text = log.habit.value.name
    }
    
    // MARK: - Name
    
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Save
    
    override func save_action() {
        if log.value.is_sick && log.value.note.isEmpty {
            if let message = table.card(id: "Message") as? LogEditMessageCard {
                message.push_empty_error()
            }
            return
        }
        
        if log.value.id == 0 {
            table.vc?.toSuperController(object: ["LogAdd": log])
        } else {
            table.vc?.toSuperController(object: ["LogUpdate": log])
        }
        table.controller?.dismiss(animated: true, completion: nil)
    }
    
}
