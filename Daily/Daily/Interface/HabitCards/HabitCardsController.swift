//
//  HabitCardsController.swift
//  Daily
//
//  Created by Myron on 2018/5/5.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - HabitCard Protocol

protocol HabitCardProtocol: HabitCardCellModelProtocol {
}

class TestHabitCardProtocol: HabitCardProtocol {
    var name: String = ""
    func today_time() -> Int {
        return Int.random(range: 0 ..< 100)
    }
    func today_note() -> Int {
        return Int.random(range: 0 ..< 100)
    }
}

// MAKR: - HabitCardsController

class HabitCardsController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        for n in ["学习英语", "跑步健身", "背诵单词", "记录日记", "打扫卫生", "洗衣做饭"] {
            let card = TestHabitCardProtocol()
            card.name = n
            cards.append(card)
        }
    }
    
    // MARK: - Datas
    
    var cards: [HabitCardProtocol] = []
    
    // MARK: - Table View
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HabitCardCell
        cell.view_update(index: indexPath, controller: self)
        return cell
    }
    
}
