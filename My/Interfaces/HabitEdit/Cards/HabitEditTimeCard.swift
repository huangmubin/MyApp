//
//  HabitEditTimeCard.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class HabitEditTimeCard: HabitEditCard {

    // MARK: - Reload
    
    /** Override: Reload */
    public override func reload() {
        date.update(
            date: Date(time: edit.habit.start)
        )
    }
    
    // MARK: - Date
    
    /**  */
    @IBOutlet weak var date: iDateSelector!

}
