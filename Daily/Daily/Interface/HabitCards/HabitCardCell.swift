//
//  HabitCardCell.swift
//  Daily
//
//  Created by Myron on 2018/5/5.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol HabitCardCellModelProtocol {
    /** 习惯名称 */
    var name: String { get }
    /** 习惯留言 */
    var message: String { get }
    /** 获取当天的记录数量 */
    var today_count: Int { get }
    /** 图片名称 */
    var image: String { get }
}

class HabitCardCell: TableViewCell {

    var cards: HabitCardsController { return controller as! HabitCardsController }
    
    // MARK: - Infos
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var back_image: UIImageView!
    
    // MARK: - Add Note
    
    @IBOutlet weak var tap_image: UIImageView!
    @IBAction func tap_action(_ sender: UIButton) {
        controller?.tableView(
            cell: self,
            user: "TapAction",
            value: nil
        )
    }
    
    // MARK: - Reload
    
    override func view_reload() {
        let obj = cards.cards[index.row]
        name.text = obj.name
        message.text = obj.message
        count.text = obj.today_count.description
        back_image.image = UIImage(named: obj.image) ?? UIImage(contentsOfFile: "\(NSHomeDirectory())/Document/Image/\(obj.image)")
    }
    
}
