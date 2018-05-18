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
        let time = log.value.date_s.first(.day).time1970 - log.value.start
        log.value.start = value.first(.day).time1970 + time
    }

}
