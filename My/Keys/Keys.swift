//
//  Keys.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** 所有的字符串 */
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
    
    /** 用于 Show 界面的 flags 字段 */
    class flags {
        static let info: String = "info"
        static let report: String = "report"
        static let calender: String = "calendar"
        static let check: String = "check"
        static let menu: String = "menu"
    }
    
    /** 用于 Show 界面的高度预设 */
    class height {
        static let info: CGFloat = 146
        static let report: CGFloat = 100
        static let calender: CGFloat = UIScreen.main.bounds.height - Keys.height.info - Keys.height.check - Keys.height.menu - 20
        static let check: CGFloat = 50
        static let menu: CGFloat = 66
    }
}
