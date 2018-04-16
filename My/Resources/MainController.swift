//
//  MainController.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class MainController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let v = CalendarView.load(nib: nil) {
            v.frame = CGRect(
                x: 20, y: 100,
                width: view.bounds.width - 40,
                height: 400
            )
            v.current = Date()
            view.addSubview(v)
        }
    }

    
}
