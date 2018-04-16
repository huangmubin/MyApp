//
//  Card.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Card: View {

    // MARK: - Values
    
    /**  */
    @IBInspectable
    var corner: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = corner
        }
    }

    // MARK: - Views
    
    @IBOutlet weak var navigation: UIView!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var left_button: UIButton!
    @IBOutlet weak var right_button: UIButton!
    
}
