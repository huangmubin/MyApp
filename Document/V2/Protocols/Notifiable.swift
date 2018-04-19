//
//  Notifier.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

// MARK: - Notifier Ptorocol

/**
 Easy notifier method.
 */
public protocol Notifiable { }
extension Notifiable {
    
    /** Observer a notify. */
    func observer(name: NSNotification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }
    
    /** Observer a notify at block */
    func observer(name: Notification.Name, object: Any? = nil, queue: OperationQueue? = nil, using: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: using)
    }
    
    /** remove observer a notify. */
    func unobserver(name: NSNotification.Name? = nil, object: Any? = nil) {
        NotificationCenter.default.removeObserver(self, name: name, object: object)
    }
    
    /** Post a notify. */
    func post(name: NSNotification.Name, infos: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, object: self, userInfo: infos)
    }
    
    /** Post a notify in specific queue. */
    func post(name: NSNotification.Name, infos: [AnyHashable: Any]? = nil, inQueue: DispatchQueue) {
        inQueue.async {
            NotificationCenter.default.post(name: name, object: self, userInfo: infos)
        }
    }
}

// MARK: - Extension String

extension String {
    
    /** Notification.Name.init(self) */
    var notify: Notification.Name {
        return Notification.Name.init(self)
    }
    
}
