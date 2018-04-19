//
//  CalendarCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {

    // MARK: - Index
    
    var index: IndexPath!
    weak var view: CalendarView!
    func update(index: IndexPath, view: CalendarView) {
        self.index = index
        self.view = view
    }
    
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
    
    // MARK: - Views
    
    @IBOutlet var label: UILabel!
    @IBOutlet var today: UIView!
    @IBOutlet var done: UIView!
    
    func update(show: Bool, today: Bool, done: Bool) {
        if show {
            self.label.isHidden = false
            self.today.isHidden = !today
            self.done.isHidden  = !done
        } else {
            self.label.isHidden = true
            self.today.isHidden = true
            self.done.isHidden  = true
        }
    }
    
    func select(_ v: Bool) {
        if v {
            self.label.layer.borderWidth = 1
            self.label.layer.borderColor = label.textColor.cgColor
            self.label.layer.cornerRadius = 6
        } else {
            self.label.layer.borderWidth = 0
        }
    }
    
    func is_absent(_ v: Bool) {
        self.done.backgroundColor = v ? Color.red.light : Color.green.light
    }
    
}
