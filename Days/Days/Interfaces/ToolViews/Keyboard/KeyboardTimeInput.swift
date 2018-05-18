//
//  KeyboardTimeInput.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol KeyboardTimeInputDelegate: class {
    func keyboard_time(_ view: KeyboardTimeInput, hour: Int, minute: Int)
}

class KeyboardTimeInput: KeyboardInput {

    weak var time_delegate: KeyboardTimeInputDelegate?
    
    // MARK: - Value
    
    var hour: Int {
        get { return Int(hour_view.text)! }
        set { hour_view.text = "\(newValue)" }
    }
    
    var minute: Int {
        get { return Int(minute_view.text)! }
        set { minute_view.text = "\(newValue)" }
    }
    
    // MARK: - Views
    
    @IBOutlet weak var hour_view: DateTextView!
    @IBOutlet weak var minute_view: DateTextView!
    
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
            if textView === hour_view {
                update_error(text: "时间不能为 \(int):\(minute_view.int)")
            } else if textView === minute_view {
                update_error(text: "时间不能为 \(hour_view.int):\(int)")
            }
        } else {
            if textView === hour_view {
                if hour_view.int == 24 {
                    minute_view.text = "00"
                }
            } else if textView === minute_view {
                if hour_view.int == 24 && minute_view.int != 0 {
                    hour_view.text = "23"
                }
            }
        }
        save_button.isHidden = (hour_view.text.isEmpty || minute_view.text.isEmpty)
    }
    
    // MARK: - Save
    
    @IBOutlet weak var save_button: UIButton!
    
    override func close(_ sender: UIButton) {
        hour_view.resignFirstResponder()
        minute_view.resignFirstResponder()
    }
    
    override func save(_ sender: UIButton) {
        hour_view.resignFirstResponder()
        minute_view.resignFirstResponder()
        time_delegate?.keyboard_time(self, hour: hour_view.int, minute: minute_view.int)
    }
    
    // MARK: - Push
    
    override func push() {
        super.push()
        hour_view.becomeFirstResponder()
    }

}
