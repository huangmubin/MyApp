//
//  HabitShowLogCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowLogCard: DaysCardView {

    @IBAction func uncheck_action(_ sender: UIButton) {
        table.controller?.performSegue(withIdentifier: "Sick", sender: nil)
    }
    
    @IBAction func check_action(_ sender: UIButton) {
        table.controller?.performSegue(withIdentifier: "Check", sender: nil)
    }
    
    @IBAction func list_action(_ sender: UIButton) {
        table.controller?.performSegue(withIdentifier: "LogList", sender: nil)
    }
    

}
