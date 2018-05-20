//
//  CardChartCollectionCell.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardChartCollectionCell: UICollectionViewCell {

    @IBOutlet weak var height_layout: NSLayoutConstraint!
    
    @IBOutlet weak var container_view: View!
    @IBOutlet weak var progress_view: View!
    
    @IBOutlet weak var title_label: UILabel!
    
    func update(title: String, progress: CGFloat) {
        title_label.text = title
        height_layout.constant = container_view.bounds.height * progress
    }
    
    
    // MARK: - Size
    
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    public func view_bounds() {
        self.progress_view.corner = min(4, self.bounds.width / 2)
    }
    
}
