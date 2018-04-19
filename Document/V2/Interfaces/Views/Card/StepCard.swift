//
//  StepCard.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class StepCard: View {
    
    // MARK: - Navigation
    
    @IBOutlet weak var navigation_height_layout: NSLayoutConstraint!
    
    // MARK: - Title
    
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Actions
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBOutlet weak var save: UIButton!
    
    // MARK: - Contrainer
    
    @IBOutlet weak var contrainer: UIView!
    
}
