//
//  Animation.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/3.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Animation {
    
}

// MARK: - 位置计算

extension Animation {
    
    /** 减速：越来越慢 */
    static func ease_out_sin(c: CGFloat, max: CGFloat) -> CGFloat {
        let flag: CGFloat = c >= 0 ? 1 : -1
        if abs(c) >= max { return max * flag }
        return flag * CGFloat(ease_out_sin(Double(abs(c) / max))) * max
    }
    
}


// MARK: - 动画曲线

extension Animation {
    
    /** 输入 0 ~ 1 */
    static func ease_out_sin(_ s: Double) -> Double {
        return sin(s * Double.pi / 2)
    }
    
}
