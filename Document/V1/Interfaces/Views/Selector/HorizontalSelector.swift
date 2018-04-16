//
//  Selector.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol HorizontalSelector_Delegate_Protocol: class {
    func horizontalSelector(update selector: HorizontalSelector, index: Int)
}

/** 水平选择器 */
class HorizontalSelector: View, UIScrollViewDelegate {
    
    @IBOutlet var label: UILabel? {
        didSet {
            if label != nil {
                for view in scroll.subviews {
                    if let v = view as? UILabel {
                        v.font = label?.font
                    }
                }
                label?.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable var text_color: UIColor = Colors.black50 {
        didSet {
            for view in scroll.subviews {
                if let label = view as? UILabel {
                    label.textColor = text_color
                }
            }
        }
    }
    @IBInspectable var text_backcolor: UIColor = UIColor.clear {
        didSet {
            for view in scroll.subviews {
                if let label = view as? UILabel {
                    label.backgroundColor = text_backcolor
                }
            }
        }
    }
    
    @IBInspectable var gradient_color: UIColor = UIColor.white {
        didSet {
            gradient.colors = [gradient_color.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, gradient_color.cgColor]
            gradient.setNeedsDisplay()
        }
    }
    
    // MARK: - Days
    
    static let normal: [String] = {
        var strs = ["", ""]
        for i in 1 ..< 100 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    static let days: [String] = {
        var strs = ["", ""]
        for i in 1 ..< 101 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    static let weeks = ["", "", "1", "2", "3", "4", "5", "6", "7", "", "", ]
    static let months = [ "", "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "", "",]
    
    
    static let hours: [String] = {
        var strs = ["", ""]
        for i in 0 ..< 24 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    
    static let minutes: [String] = {
        var strs = ["", ""]
        for i in 0 ..< 60 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    
    // MARK: - Datas
    
    var datas: [String] = HorizontalSelector.weeks
    var scroll: UIScrollView = UIScrollView(frame: CGRect.zero)
    var gradent_view: UIView = UIView()
    var gradient: CAGradientLayer = CAGradientLayer()
    var index: Int = 0 {
        didSet {
            delegate?.horizontalSelector(update: self, index: index)
        }
    }
    
    weak var delegate: HorizontalSelector_Delegate_Protocol?
    
    // MARK: - View Deploy
    
    override func view_deploy() {
        self.clipsToBounds = true
        
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        addSubview(scroll)
        
        addSubview(gradent_view)
        gradent_view.backgroundColor = UIColor.clear
        gradent_view.isUserInteractionEnabled = false
        gradient.colors = [gradient_color.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, gradient_color.cgColor]
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradent_view.layer.addSublayer(gradient)
        
        view_bounds()
    }
    
    override func view_bounds() {
        let width = bounds.width / 5
        scroll.frame = CGRect(x: -width / 2, y: 0, width: width * 6, height: bounds.height)
        scroll.contentSize = CGSize(
            width: scroll.bounds.width / 5 * CGFloat(datas.count),
            height: bounds.height
        )
        reload_labels()
        
        gradent_view.frame = bounds
        gradient.frame = bounds
        gradient.setNeedsDisplay()
    }
    
    func reload(datas: [String]) {
        self.datas = datas
        index = 0
        scroll.contentOffset.x = 0
        view_bounds()
    }
    
    func reload_labels() {
        let size = CGSize(width: scroll.bounds.width / 5, height: scroll.bounds.height)
        for v in scroll.subviews {
            if v.tag >= datas.count {
                v.removeFromSuperview()
            }
        }
        for i in 0 ..< datas.count {
            if let label = scroll.viewWithTag(i + 1) as? UILabel {
                label.frame = CGRect(
                    x: CGFloat(i) * size.width, y: 0,
                    width: size.width, height: size.height
                )
                label.text = datas[i]
            } else {
                let label = UILabel(frame: CGRect(
                    x: CGFloat(i) * size.width, y: 0,
                    width: size.width, height: size.height
                ))
                label.tag = i + 1
                label.textColor = self.label?.textColor ?? text_color
                label.backgroundColor = text_backcolor
                label.font = self.label?.font ?? UIFont.boldSystemFont(ofSize: 80)
                label.textAlignment = .center
                label.text = datas[i]
                scroll.addSubview(label)
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width / 5
        index = Int(scrollView.contentOffset.x / width + 0.5)
        //print("Horizontal Selector index = \(index)")
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = CGFloat(index) * scrollView.bounds.width / 5
        if scrollView.contentOffset.x != x {
            UIView.animate(withDuration: 0.25, animations: {
                self.scroll.contentOffset.x = x
            })
        }
    }
    
    // MARK: - Move
    
    func move_to_index(_ index: Int) {
        self.index = index
        let width = scroll.bounds.width / 5 * CGFloat(index)
        self.scroll.setContentOffset(CGPoint(x: width, y: 0), animated: true)
    }
    
}
