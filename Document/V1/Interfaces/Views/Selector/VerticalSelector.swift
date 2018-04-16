//
//  VerticalSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol VerticalSelector_Delegate_Protocol: class {
    func verticalSelector(update selector: VerticalSelector, index: Int)
}

/** 水平选择器 */
class VerticalSelector: View, UIScrollViewDelegate {
    
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
    
    static let months: [String] = {
        var strs = ["", ""]
        for i in 1 ..< 13 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    
    static let years: [String] = {
        var strs = ["", ""]
        for i in 2018 ..< 2118 {
            strs.append("\(i)")
        }
        return strs + ["", ""]
    }()
    
    // MARK: - Datas
    
    var datas: [String] = VerticalSelector.months
    var scroll: UIScrollView = UIScrollView(frame: CGRect.zero)
    var gradent_view: UIView = UIView()
    var gradient: CAGradientLayer = CAGradientLayer()
    var index: Int = 0 {
        didSet {
            delegate?.verticalSelector(update: self, index: index)
        }
    }
    
    weak var delegate: VerticalSelector_Delegate_Protocol?
    
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
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradent_view.layer.addSublayer(gradient)
        
        view_bounds()
    }
    
    override func view_bounds() {
        let height = bounds.height / 5
        scroll.frame = CGRect(x: 0, y: -height / 2, width: bounds.width, height: height * 6)
        scroll.contentSize = CGSize(
            width: scroll.bounds.width,
            height: scroll.bounds.height / 5 * CGFloat(datas.count)
        )
        reload_labels()
        
        gradent_view.frame = bounds
        gradient.frame = bounds
        gradient.setNeedsDisplay()
    }
    
    func reload(datas: [String]) {
        self.datas = datas
        index = 0
        scroll.contentOffset.y = 0
        view_bounds()
    }
    
    func reload_labels() {
        let size = CGSize(width: scroll.bounds.width, height: scroll.bounds.height / 5)
        for v in scroll.subviews {
            if v.tag >= datas.count {
                v.removeFromSuperview()
            }
        }
        for i in 0 ..< datas.count {
            if let label = scroll.viewWithTag(i + 1) as? UILabel {
                label.frame = CGRect(
                    x: 0, y: CGFloat(i) * size.height,
                    width: size.width, height: size.height
                )
                label.text = datas[i]
            } else {
                let label = UILabel(frame: CGRect(
                    x: 0, y: CGFloat(i) * size.height,
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
        let height = scrollView.bounds.height / 5
        index = Int(scrollView.contentOffset.y / height + 0.5)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let y = CGFloat(index) * scrollView.bounds.height / 5
        if scrollView.contentOffset.y != y {
            UIView.animate(withDuration: 0.25, animations: {
                self.scroll.contentOffset.y = y
            })
        }
    }
    
    // MARK: - Move
    
    func move_to_index(_ index: Int) {
        self.index = index
        let height = scroll.bounds.height / 5 * CGFloat(index)
        self.scroll.setContentOffset(CGPoint(x: 0, y: height), animated: true)
    }
}

