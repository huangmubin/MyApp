//
//  LogEditDateCard.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditDateCard: LogEditCard {

    /** Date 20180610 */
    var value: Int {
        return date_selector.date().date
    }
    
    // MARK: - Date
    
    /**  */
    @IBOutlet weak var layout_bottom: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var layout_top: NSLayoutConstraint!
    
    /**  */
    @IBAction func date_action(_ sender: UIButton) {
        if self.frame.size.height < 200 {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = 200
                self.table.update_content_size()
                self.layout_bottom.constant = -70
                self.layout_top.constant = 70
                self.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = 120
                self.table.update_content_size()
                self.layout_bottom.constant = -10
                self.layout_top.constant = 10
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Select
    
    /**  */
    @IBOutlet weak var date_selector: iDateSelector!
    
    // MARK: - Reload
    
    /**  */
    override func reload() {
        date_selector.update(date: Date(time: log.start), animate: false)
    }

}
