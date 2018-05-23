//
//  CardChartCollectionCell.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardChartCollectionCell: UICollectionViewCell {

    @IBOutlet weak var progress_height_layout: NSLayoutConstraint!
    @IBOutlet weak var progress_leading_layout: NSLayoutConstraint!
    
    @IBOutlet weak var progress_view: View!
    @IBOutlet weak var title_label: UILabel!
    
    func update(title: String, progress: CGFloat, size: CGSize) {
        title_label.text = title
        progress_height_layout.constant = (size.height - 14) / 3 * 2 * progress
        progress_leading_layout.constant = size.width * 0.2
        progress_view.corner = min(size.width * 0.4, 2)
    }
    
}
