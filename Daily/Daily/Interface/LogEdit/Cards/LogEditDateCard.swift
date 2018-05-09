//
//  LogEditDateCard.swift
//  Daily
//
//  Created by Myron on 2018/5/9.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditDateCard: LogEditCard {

    // MARK: - Date
    
    @IBOutlet weak var date_button: UIButton!
    
    @IBAction func date_action(_ sender: UIButton) {
        if self.frame.size.height < 200 {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = 200
                self.table.update_content_size()
                self.layoutIfNeeded()
            }, completion: { _ in
                let date = Date(time: self.log.start)
//                self.date_selector.isHidden = false
                self.date_selector.update(date: date)
                DispatchQueue.global().async {
                    Thread.sleep(forTimeInterval: 0.5)
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.25, animations: {
                            self.date_selector.alpha = 1
                        })
                    }
                }
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.date_selector.alpha = 0
                self.frame.size.height = 130
                self.table.update_content_size()
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    // MARK: - Select
    
    @IBOutlet weak var date_selector: iDateSelector!
    
    // MARK: - Reload
    
    override func reload() {
        let date = Date(time: log.start)
        date_button.setTitle("\(date.year) 年 \(date.month) 月 \(date.day) 日", for: .normal)
        date_selector.update(date: date)
    }

}
