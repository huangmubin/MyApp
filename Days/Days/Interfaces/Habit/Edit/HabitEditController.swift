//
//  HabitEditController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitEditController: ViewController, HabitObject {
    
    var habit: Habit!
    
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
                habit.value.color = color
                ui.reload()
            }
        }
        if let image = messages.removeValue(forKey: "Image") as? String {
            if let ui = cards.card(id: "UI") as? HabitEditUICard {
                habit.value.image = image
                ui.reload()
            }
        }
    }
    
    // MARK: - Cards
    
    @IBOutlet weak var cards: CardTable!
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = segue.controller as? ImageController {
            image.color = habit.value.color
        }
    }
    
}
