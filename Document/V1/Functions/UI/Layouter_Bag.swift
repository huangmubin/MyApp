//
//  Layouter_Bag.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Operator Bag

extension Layouter {
    class Bag {
        
        var layouts = [NSLayoutConstraint: [UIInterfaceOrientation]]()
        
        // MARK: - Set
        
        @discardableResult
        func orient(_ orient: UIInterfaceOrientation, _ layouts: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
            for layout in layouts {
                if let orients = self.layouts[layout] {
                    if !orients.contains(orient) {
                        self.layouts[layout] = orients + [orient]
                    }
                }
            }
            return layouts
        }
        
        @discardableResult
        func all_orient(_ layouts: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
            for layout in layouts {
                self.layouts[layout] = [
                    UIInterfaceOrientation.portrait,
                    UIInterfaceOrientation.portraitUpsideDown,
                    UIInterfaceOrientation.landscapeLeft,
                    UIInterfaceOrientation.landscapeRight,
                    UIInterfaceOrientation.unknown
                ]
            }
            return layouts
        }
        
        // MARK: - Print
        
        func log() {
//            for (layout, orients) in self.layouts {
//                print("\(layout.firstItem) - \(layout.secondItem); \(layout.multiplier) \(layout.)")
//            }
        }
        
        // MARK: - Init
        
        init() {
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
        }
        deinit { NotificationCenter.default.removeObserver(self) }
        
        // MARK: - Orientation Observer
        
        @objc private func orientation_changed() {
            DispatchQueue.main.async {
                for (layout, orients) in self.layouts {
                    if !layout.isActive {
                        if orients.contains(UIApplication.shared.statusBarOrientation) {
                            layout.isActive = true
                        }
                    }
                }
            }
        }
        
        @objc private func orientation_will_change() {
            DispatchQueue.main.async {
                for (layout, _) in self.layouts {
                    if layout.isActive {
                        layout.isActive = false
                    }
                }
            }
        }
        
    }
}
