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
        title.text = log.habit.value.name
    }
    
    override func save_action() {
        if log.value.id == 0 {
            table.vc?.toSuperController(object: ["LogAdd": log])
        } else {
            table.vc?.toSuperController(object: ["LogUpdate": log])
        }
        table.controller?.dismiss(animated: true, completion: nil)
    }
    
}
