//
//  ImageCell.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var select_layout: NSLayoutConstraint!
    
    func select_animate(complete: @escaping () -> Void) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 30, options: .allowAnimatedContent, animations: {
            self.select_layout.constant = -10
            self.layoutIfNeeded()
        }, completion: { _ in
            complete()
        })
    }
    
}
