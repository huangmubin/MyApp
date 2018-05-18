//
//  LogEditDateCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditDateCard: CardDateView {

    override func update_date() {
        log.value.date = value.date
        print("update date = \(value)")
    }

}
