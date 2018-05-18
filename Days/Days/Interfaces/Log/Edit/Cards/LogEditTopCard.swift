//
//  LogEditTopCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditTopCard: CardTopView {
    
    override func save_action() {
        table.controller?.dismiss(animated: true, completion: nil)
    }
    
}
