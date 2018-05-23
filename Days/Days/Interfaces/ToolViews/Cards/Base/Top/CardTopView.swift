//
//  CardTopView.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** Top Action */
public class CardTopView: DaysCardView {

    /** Title in center */
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Left
    
    /** left button, default error */
    @IBOutlet weak var left: UIButton!
    /** Left action */
    @IBAction func left_action() {
        cancel_action()
    }
    /** Override: left action */
    public func cancel_action() {
        self.table.controller?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Right
    
    /** Right Button */
    @IBOutlet weak var right: UIButton!
    /** Right action */
    @IBAction func rigth_action() {
        save_action()
    }
    /** Override: right action */
    public func save_action() { }
    
}
