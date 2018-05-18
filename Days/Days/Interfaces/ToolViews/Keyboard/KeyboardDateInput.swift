//
//  KeyboardDateInput.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class DateTextView: UITextView {
    
    @IBInspectable var max: Int = 2100
    @IBInspectable var min: Int = 2000
    
    var old: String = "0"
    
    var int: Int { return Int(text.isEmpty ? "0" : text)! }
    
    /** success nil; error int */
    func update() -> Int? {
        var result: Int? = nil
        if int < min || int > max {
            result = int
            text = old
        } else {
            old = text
        }
        return result
    }
}

protocol KeyboardDateInputDelegate: class {
    func keyboard_date(_ view: KeyboardDateInput, year: Int, month: Int, day: Int)
}

class KeyboardDateInput: KeyboardInput {

    weak var date_delegate: KeyboardDateInputDelegate?
    
    // MARK: - Value
    
    var year: Int {
        get { return Int(year_view.text)! }
        set { year_view.text = "\(newValue)" }
    }
    
    var month: Int {
        get { return Int(month_view.text)! }
        set { month_view.text = "\(newValue)" }
    }
    
    var day: Int {
        get { return Int(day_view.text)! }
        set { day_view.text = "\(newValue)" }
    }
    
    // MARK: - Views
    
    @IBOutlet weak var year_view: DateTextView!
    @IBOutlet weak var month_view: DateTextView!
    @IBOutlet weak var day_view: DateTextView!
    
    // MARK: - Error
    
    @IBOutlet weak var error_label: UILabel!
    
    func update_error(text: String) {
        error_label.text = text
        error_label.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.error_label.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 2, options: .curveEaseIn, animations: {
                self.error_label.alpha = 0
            }, completion: { _ in })
        })
    }
    
    // MARK: - Text View Delegate
    
    override func textViewDidChange(_ textView: UITextView) {
        let date_text = textView as! DateTextView
        if let int = date_text.update() {
            if textView === year_view {
                update_error(text: "年份不能为 \(int)")
            } else if textView === month_view {
                update_error(text: "月份不能为 \(int)")
            } else if textView === day_view {
                update_error(text: "日期不能为 \(int)")
            }
        }
        save_button.isHidden = (year_view.int == 0 || month_view.int == 0 || day_view.int == 0)
    }

    // MARK: - Save
    
    @IBOutlet weak var save_button: UIButton!
    
    override func close(_ sender: UIButton) {
        year_view.resignFirstResponder()
        month_view.resignFirstResponder()
        day_view.resignFirstResponder()
    }
    
    override func save(_ sender: UIButton) {
        year_view.resignFirstResponder()
        month_view.resignFirstResponder()
        day_view.resignFirstResponder()
        date_delegate?.keyboard_date(self, year: year, month: month, day: day)
    }
    
    // MARK: - Push
    
    override func push() {
        super.push()
        day_view.becomeFirstResponder()
    }
}
