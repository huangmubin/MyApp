//
//  Frequency.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class Frequency: View {

    // MARK: - Values
    
    var every: Int = 0 {
        didSet {
            for button in [day_button, week_button, month_button] {
                if button?.tag ?? 0 == every {
                    button?.backgroundColor = button_background_color
                } else {
                    button?.backgroundColor = nil
                }
            }
        }
    }
    var times: Int {
        return (selector_view?.index ?? 0) + 1
    }
    
    @IBInspectable var button_background_color: UIColor = UIColor.yellow {
        didSet {
            every = Int(every)
        }
    }
    
    // MARK: - Buttons
    
    @IBOutlet weak var day_button: UIButton!
    @IBOutlet weak var week_button: UIButton!
    @IBOutlet weak var month_button: UIButton!
    
    @IBAction func every_action(_ sender: UIButton) {
        every = sender.tag
        switch every {
        case 0:
            selector_label.text = "How many times a day?"
            selector_view.reload(datas: HorizontalSelector.days)
        case 1:
            selector_label.text = "How many times a week?"
            selector_view.reload(datas: HorizontalSelector.weeks)
        case 2:
            selector_label.text = "How many times a month?"
            selector_view.reload(datas: HorizontalSelector.months)
        default: break
        }
    }
    
    // MARK: - Selector
    
    @IBOutlet weak var selector_label: UILabel!
    @IBOutlet weak var selector_view: HorizontalSelector!
    
}
