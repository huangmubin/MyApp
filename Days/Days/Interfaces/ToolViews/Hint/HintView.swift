//
//  HintView.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/21.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol HintViewDelegate: class {
    func hint_view(sure_action view: HintView)
}

class HintView: View {

    weak var delegate: HintViewDelegate?
    
    deinit {
        print("HintView is deinit.")
    }
    
    // MARK: - Window
    
    var mask_window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    /** default 0.2 */
    @IBInspectable var window_alpha: CGFloat = 0.2 {
        didSet {
            mask_window.backgroundColor = UIColor.white.withAlphaComponent(window_alpha)
        }
    }
    
    // MARK: - Deploy
    
    override func view_deploy() {
        print("HintView is view deploy.")
        mask_window.backgroundColor = UIColor.white.withAlphaComponent(window_alpha)
        mask_window.windowLevel = UIWindowLevelStatusBar
        mask_window.alpha = 1
        
        self.frame = CGRect(x: 20, y: (UIScreen.main.bounds.height - 260) / 2, width: UIScreen.main.bounds.width - 40, height: 260)
        mask_window.addSubview(self)
    }
    
    /** Push in windown */
    func push() {
        self.mask_window.makeKeyAndVisible()
    }
    
    // MARK: - Title
    
    @IBOutlet weak var title_label: UILabel!
    
    // MARK: - Message
    
    @IBOutlet weak var message_label: UILabel!
    
    // MARK: - Actions
    
    @IBOutlet weak var sure_button: Button!
    @IBOutlet weak var cancel_button: Button!
    
    @IBAction func sure_action(_ sender: Button) {
        delegate?.hint_view(sure_action: self)
        //self.mask_window.isHidden = true
        self.mask_window.resignKey()
    }
    @IBAction func cancel_action(_ sender: Button) {
        //self.mask_window.isHidden = true
        self.mask_window.resignKey()
    }
    
}
