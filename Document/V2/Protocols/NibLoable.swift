//
//  NibLoable.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol NibLoable { }
extension NibLoable where Self: UIView {
    
    /** 从 xib 里 加载 */
    static func load(nib: String? = nil) -> Self? {
        return Bundle.main.loadNibNamed(nib ?? "\(self)", owner: nil, options: nil)?.first as? Self
    }
    
}
extension UIView: NibLoable { }
