//
//  LogEditController.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit


extension CardView {
    
    var log: Log {
        return (table.controller as! LogEditController).log
    }
    
}

class LogEditController: ViewController {

    var log: Log!
    
    // MARK: - Cards
    
    @IBOutlet weak var cards: CardTable!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.controller = self
        cards.reload()
    }

}
