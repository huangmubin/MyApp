//
//  Color.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Color {
    
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

// MARK: - Red

extension Color {
    
    class red {
        static var light: UIColor { return Color.color(0xFFA6B1) }
        static var deep: UIColor { return Color.color(0xF51733) }
    }
    
}

// MARK: - Green

extension Color {
    class green {
        static var light: UIColor { return Color.color(0xDFFFBF) }
    }
}

// MARK: - Gray

extension Color {
    class gray {
        static var light: UIColor { return Color.color(250, 250, 250, 1) }
    }
}

// MARK: - Background

extension Color {
    class back {
        static var light: UIColor { return Color.color(0xFFFFFF) }
        static var dark: UIColor { return Color.color(30, 30, 30, 1) }
    }
}

// MARK: - Text

extension Color {
    class text {
        static var light: UIColor { return UIColor.white }
        static var dark: UIColor { return Color.color(30, 30, 30, 1) }
        class hint {
            static var light: UIColor { return Color.color(255, 255, 255, 0.3) }
            static var dark: UIColor { return Color.color(0, 0, 0, 0.3) }
        }
    }
}

// MARK: - Other

extension Color {
    static var white: UIColor { return UIColor.white }
    static var clear: UIColor { return UIColor.white.withAlphaComponent(0) }
    static var black: UIColor { return UIColor.black }
}

