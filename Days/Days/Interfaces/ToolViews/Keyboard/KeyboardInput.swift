//
//  KeyboardInput.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol KeyboardInputDelegate: class {
    func keyboard_input(input: KeyboardInput, save value: String)
}

// 117 + 43 = 160
class KeyboardInput: View, UITextViewDelegate {
    
    var id: String = ""
    
    deinit {
        print("KeyboardInput is deinit.")
    }
    
    // MARK: - Window
    
    var mask_window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Deploy
    
    override func view_deploy() {
        print("KeyboardInput is view deploy.")
        mask_window.backgroundColor = UIColor.white.withAlphaComponent(window_alpha)
        mask_window.windowLevel = UIWindowLevelStatusBar
        mask_window.alpha = 1
        
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 160)
        mask_window.addSubview(self)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboard_will_change_frame(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    // MARK: - Interface
    
    /** input Values */
    var value: String {
        get { return input.text }
        set {
            input.text = newValue
            textViewDidChange(input)
        }
    }
    
    weak var delegate: KeyboardInputDelegate?
    
    /** Push in windown */
    func push() {
        self.mask_window.makeKeyAndVisible()
        self.input?.becomeFirstResponder()
    }
    
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
    
    // MARK: - IBOutlet
    
    /** default 0.2 */
    @IBInspectable var window_alpha: CGFloat = 0.2 {
        didSet {
            mask_window.backgroundColor = UIColor.white.withAlphaComponent(window_alpha)
        }
    }
    
    @IBOutlet weak var input: UITextView!
    
    func textViewDidChange(_ textView: UITextView) {
        let height = input.sizeThatFits(input.bounds.size).height + 117
        if frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame = CGRect(
                    x: 0,
                    y: self.keyboard_minY - height,
                    width: UIScreen.main.bounds.width,
                    height: height
                )
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Title
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var title_width: NSLayoutConstraint!
    
    func update_title(title: String) {
        self.title.text = title
        title_width.constant = self.title.sizeThatFits(self.title.bounds.size).width
        self.layoutIfNeeded()
    }
    
    // MARK: - Save
    
    @IBAction func close(_ sender: UIButton) {
        input.resignFirstResponder()
    }
    
    @IBAction func save(_ sender: UIButton) {
        input.resignFirstResponder()
        delegate?.keyboard_input(input: self, save: value)
    }
    
    // MARK: - Keyboard Observer
    
    var keyboard_minY: CGFloat = 0
    
    @objc func keyboard_will_change_frame(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboard_will_change_frame(keyboard: rect.cgRectValue)
            }
        }
    }
    
    /** keyboard will change to the new rect */
    func keyboard_will_change_frame(keyboard rect: CGRect) {
        keyboard_minY = rect.minY
        if rect.minY < UIScreen.main.bounds.height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.origin.y = self.keyboard_minY - self.frame.height
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.origin.y = rect.minY
            }, completion: { _ in
                self.removeFromSuperview()
                self.mask_window.isHidden = true
            })
        }
    }
    
    // MARK: - Title Layout
    
    @IBOutlet weak var title_layout: NSLayoutConstraint!
    
    func update_title_layout() {
        title_layout.constant = title.sizeThatFits(title.bounds.size).width
        layoutIfNeeded()
    }
    
}
