//
//  HabitEditNameCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/19.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditNameCell: HabitEditCell, UITextViewDelegate {

    /** name text view */
    @IBOutlet weak var view: UITextView!
    
    override func view_reload() {
        view.text = edit?.habit.name
        view.delegate = self
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        if height_count() != card.height {
            card.height = height_count()
            table.reloadRows(at: [index], with: .automatic)
        }
    }
    
    // MARK: - Height
    
    /** 计算最新的高度 */
    func height_count() -> CGFloat {
        if view.text.isEmpty == true {
            return 90
        } else {
            return view.sizeThatFits(view.bounds.size).height + 50
        }
    }
    
}
