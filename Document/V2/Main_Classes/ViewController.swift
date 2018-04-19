//
//  ViewController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - 便捷属性
    
    var width: CGFloat { return UIScreen.main.bounds.width }
    var height: CGFloat { return UIScreen.main.bounds.height }
    
    // MARK: - 初始化
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(nib: String? = nil) {
        super.init(nibName: nib, bundle: nil)
    }

    // MAKR: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Controller: \(self.classForCoder) is view did load.")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation_will_change),
            name: .UIApplicationWillChangeStatusBarOrientation,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation_changed),
            name: .UIApplicationDidChangeStatusBarOrientation,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboard_will_change_frame(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Controller: \(self.classForCoder) is deinit.")
    }
    
    // MARK: - 旋转方向
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Orientation Observer
    
    @objc private func orientation_changed() {
        DispatchQueue.main.async {
            self.orientation_changed_action()
        }
    }
    
    @objc private func orientation_will_change() {
        DispatchQueue.main.async {
            self.orientation_will_change_action()
        }
    }
    
    /** Override: Call when orientation changed at main queue */
    func orientation_changed_action() { }
    
    /** Override: Call when orientation will change at main queue */
    func orientation_will_change_action() { }
    
    // MARK: - Keyboard Observer
    
    @objc func keyboard_will_change_frame(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboard_will_change_frame(keyboard: rect.cgRectValue)
            }
        }
    }
    
    /** keyboard will change to the new rect */
    func keyboard_will_change_frame(keyboard rect: CGRect) { }
    
    // MARK: - Transport the Data
    
    /** Messages from other controller */
    var messages: [String: Any] = [:]
    
    /** Send message to the Super Controller (presentingViewController) */
    func toSuperController(object: [String: Any]) {
        if let controller = self.presentingViewController as? ViewController {
            for (key, value) in object {
                controller.messages[key] = value
            }
        }
    }
    
    // MARK: - Table View Cell
    
    /** Call when the table view cell have user touch then cell it. */
    func tableView(cell: TableViewCell, user action: String) { }
    
}


