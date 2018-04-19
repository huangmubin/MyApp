//
//  View.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class View: UIView {

    // MARK: - Datas
    
    // MARK: 圆角控制
    
    @IBInspectable var corner: CGFloat = 0 {
        didSet { self.layer.cornerRadius = corner }
    }
    
    // MARK: 边框控制
    
    @IBInspectable var border_color: UIColor? = nil {
        didSet { self.layer.borderColor = border_color?.cgColor }
    }
    
    @IBInspectable var border: CGFloat = 0 {
        didSet { self.layer.borderWidth = border }
    }
    
    // MARK: - 初始化
    
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
    
    // MARK: - 尺寸变化
    
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

// MARK: - 通知

extension View: Notifiable { }
