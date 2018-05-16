//
//  HabitEditController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditController: ViewController {

    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.controller = self
        cards.reload()
    }
    
    // MARK: - Message
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let color = messages.removeValue(forKey: "Color") as? Int {
            if let ui = cards.card(id: "UI") as? HabitEditUICard {
                ui.color.normal_color = UIColor(UInt(color))
            }
        }
        if let image = messages.removeValue(forKey: "Image") as? Int {
            if let ui = cards.card(id: "UI") as? HabitEditUICard {
                ui.image.setImage(UIImage(contentsOfFile: ""), for: .normal)
            }
        }
    }
    
    // MARK: - Cards
    
    @IBOutlet weak var cards: CardTable!
    
}
