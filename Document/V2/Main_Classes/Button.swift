//
//  Button.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    @IBInspectable var is_select: Bool = false {
        didSet {
            self.backgroundColor = is_select ? select_color : normal_color
        }
    }
    
    @IBInspectable var normal_color: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = is_select ? select_color : normal_color
        }
    }
    
    @IBInspectable var select_color: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor = is_select ? select_color : normal_color
        }
    }
    
}
