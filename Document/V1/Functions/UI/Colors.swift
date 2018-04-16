//
//  Colors.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Colors {
    
    static func color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static func color(_ v: UInt, _ a: UInt = 100) -> UIColor {
        return color(
            CGFloat((v & 0xFF0000) >> 16),
            CGFloat((v & 0x00FF00) >> 8),
            CGFloat((v & 0x0000FF)),
            CGFloat(a) / 100
        )
    }
    
}

// MARK: - Normal Color

extension Colors {
    
    static var white: UIColor {
        return color(255, 255, 255, 1)
    }
    
    static var black50: UIColor {
        return color(50, 50, 50, 1)
    }
    
    static var gray230: UIColor {
        return color(230, 230, 230, 1)
    }
    
    static var green223: UIColor {
        return color(223, 255, 3, 1)
    }
    
    static var red98: UIColor {
        return color(255, 98, 0, 1)
    }
    
    static var red187: UIColor {
        return color(255, 187, 187, 1)
    }
}

// MARK: - Tint color

extension Colors {
    
    // MARK: Red
    
    static var red_light: UIColor {
        return color(0xFFA6B1)
    }
    
    static var red_deep: UIColor {
        return color(0xF51733)
    }
    
    // MARK: Green
    
    static var green_light: UIColor {
        return color(0xDFFFBF)
    }
    
    // MARK: Other
    
    static var clear: UIColor {
        return UIColor.white.withAlphaComponent(0)
    }
    
    // MARK: Gray
    
    static var gray_light: UIColor {
        return color(250, 250, 250, 1)
    }
    
    // MARK: Back
    
    static var back_light: UIColor {
        return color(0xFFFFFF)
    }
    
    static var back_dark: UIColor {
        return color(0x000000)
    }
    
    // MARK: Text
    
    static var text_dark: UIColor {
        return color(30, 30, 30, 1)
    }
    
    static var text_light: UIColor {
        return UIColor.white
    }
    
    static var text_hint_light: UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    static var text_hint_dark: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
}
