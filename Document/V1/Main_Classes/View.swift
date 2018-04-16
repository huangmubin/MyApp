//
//  View.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit


class View: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** 初始化 */
    func view_deploy() { }
    
    // MARK: - Frame
    
    override var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    /** 大小变化 */
    func view_bounds() { }
    
}
