//
//  InputView.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/29.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol InputView_Delegate: NSObjectProtocol {
    func inputview(_ view: InputView, save_action text: String)
}

/** 提供一个输入框 */
class InputView: View {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(delegate: InputView_Delegate) {
        super.init(frame: UIScreen.main.bounds)
        self.delegate = delegate
    }
    
    // MARK: - Delegate
    
    weak var delegate: InputView_Delegate?
    
    // MARK: - Deploy
    
    override func view_deploy() {
        effect.frame = bounds
        addSubview(effect)
        
        card.backgroundColor = UIColor.white
        card.layer.cornerRadius = 20
        card.frame = CGRect(
            x: 30, y: 1000,
            width: bounds.width - 60,
            height: 200
        )
        addSubview(card)
        
        title.font = UIFont(name: "PingFangSC-Light", size: 20)
        title.textColor = Color.text.hint.dark
        title.text = "Input message"
        title.frame = CGRect(
            x: 20, y: 20, width: card.frame.width - 40, height: 26
        )
        card.addSubview(title)
        
        text.font = UIFont(name: "PingFangSC-Light", size: 20)
        text.textColor = Color.text.dark
        text.backgroundColor = Color.gray.light
        text.frame = CGRect(
            x: 20, y: title.frame.maxY + 10,
            width: card.frame.width - 40,
            height: card.frame.height - title.frame.maxY - 60
        )
        card.addSubview(text)
        
        cancel.titleLabel?.font = UIFont(name: "PingFangSC-Light", size: 20)
        cancel.setTitleColor(Color.text.dark, for: .normal)
        cancel.setTitle("Cancel", for: .normal)
        cancel.addTarget(self, action: #selector(cancel_action), for: .touchUpInside)
        cancel.frame = CGRect(
            x: 20, y: text.frame.maxY + 10,
            width: (card.frame.width - 60) / 2,
            height: 30
        )
        card.addSubview(cancel)
        
        save.titleLabel?.font = UIFont(name: "PingFangSC-Light", size: 20)
        save.setTitleColor(Color.text.dark, for: .normal)
        save.setTitle("Save", for: .normal)
        save.addTarget(self, action: #selector(save_action), for: .touchUpInside)
        save.frame = CGRect(
            x: cancel.frame.maxX + 20, y: text.frame.maxY + 10,
            width: (card.frame.width - 60) / 2,
            height: 30
        )
        card.addSubview(save)
        
        add_observer()
        
        self.text.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Bounds
    
    override func view_bounds() {
        effect.frame = bounds
        
        let h = is_open == nil ? 200 : bounds.height - is_open!.height - 130
        let y = is_open == nil ? bounds.height :  bounds.height - is_open!.height - h - 60
        card.frame = CGRect(
            x: 30, y: y,
            width: bounds.width - 60,
            height: h
        )
    }
    
    func card_bounds() {
        title.frame = CGRect(
            x: 20, y: 20, width: card.frame.width - 40, height: 26
        )
        
        text.frame = CGRect(
            x: 20, y: title.frame.maxY + 10,
            width: card.frame.width - 40,
            height: card.frame.height - title.frame.maxY - 60
        )
        
        cancel.frame = CGRect(
            x: 20, y: text.frame.maxY + 10,
            width: (card.frame.width - 60) / 2,
            height: 30
        )
        save.frame = CGRect(
            x: cancel.frame.maxX + 20, y: text.frame.maxY + 10,
            width: (card.frame.width - 60) / 2,
            height: 30
        )
    }
    
    // MARK: - Effect
    
    /** 模糊视图 */
    var effect: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - Card
    
    /** 背景视图 */
    var card: UIView = UIView()
    
    // MARK: - Title
    
    /** 标题 */
    var title: UILabel = UILabel()
    
    // MARK: - Text
    
    var text: UITextView = UITextView()
    
    // MARK: - Cancel
    
    var cancel: UIButton = UIButton(type: UIButtonType.system)
    
    @objc func cancel_action() {
        text.resignFirstResponder()
    }
    
    // MARK: - Save
    
    var save: UIButton = UIButton(type: UIButtonType.system)
    
    @objc func save_action() {
        delegate?.inputview(self, save_action: text.text)
        text.resignFirstResponder()
    }
    
    // MARK: - Keyboard
    
    func add_observer() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(observer_action(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    @objc func observer_action(_ sender: NSNotification) {
        if let info = sender.userInfo {
            if let rect_value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let rect = rect_value.cgRectValue
                if rect.minY >= UIScreen.main.bounds.height - 20 {
                    self.close_animate(rect: rect)
                } else {
                    self.open_animate(rect: rect)
                }
            }
        }
    }
    
    // MARK: - Animate
    
    var is_open: CGRect? = nil
    
    func open_animate(rect: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            let h = self.bounds.height - rect.height - 130
            let y = self.bounds.height - rect.height - h - 60
            self.card.frame = CGRect(
                x: 30, y: y,
                width: self.bounds.width - 60,
                height: h
            )
            self.card_bounds()
        }, completion: { _ in
            self.is_open = rect
        })
    }
    
    func close_animate(rect: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            self.card.frame.origin.y = self.bounds.height
        }, completion: { [weak self] _ in
            self?.is_open = nil
            self?.removeFromSuperview()
        })
    }
    
}
