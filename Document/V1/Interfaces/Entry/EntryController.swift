//
//  EntryController.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/12.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class EntryController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let v = InputView(frame: view.bounds)
        view.addSubview(v)
    }

}
