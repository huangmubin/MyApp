//
//  ColorCell.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    @IBOutlet weak var color_view: View!
    
    @IBOutlet weak var select_view: UIImageView!
    @IBOutlet weak var select_layout: NSLayoutConstraint!
    
    func select_animate(complete: @escaping () -> Void) {
        select_view.isHidden = false
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 30, options: .curveEaseOut, animations: {
            self.select_layout.constant = self.frame.height
            self.layoutIfNeeded()
        }, completion: { _ in
            complete()
        })
    }
    
}
