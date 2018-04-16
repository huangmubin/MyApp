//
//  Keys.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Keys {
    class add {
        static let log: String = "keys-add-log"
        static let habit: String = "keys-add-habit"
    }
    class update {
        static let log: String = "keys-update-log"
        static let habit: String = "keys-update-habit"
    }
    class delete {
        static let log: String = "keys-delete-log"
        static let habit: String = "keys-delete-habit"
    }
    class open {
        static let log: String = "keys-open-log"
        static let ulog: String = "keys-open-ulog"
    }
    class control {
        static let save: String = "keys-control-save"
        static let cancel: String = "keys-control-cancel"
        static let delete: String = "keys-control-delete"
    }
    
    class flags {
        static let info: String = "info"
        static let report: String = "report"
        static let calender: String = "calendar"
        static let check: String = "check"
        static let menu: String = "menu"
    }
    class height {
        static let header: CGFloat = 146
        static let calender: CGFloat = UIScreen.main.bounds.height - Keys.height.header - Keys.height.check - Keys.height.footer - 20
        static let check: CGFloat = 50
        static let footer: CGFloat = 66
    }
}
