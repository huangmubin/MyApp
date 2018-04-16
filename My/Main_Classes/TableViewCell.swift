//
//  TableViewCell.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/2.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        view_deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** View Deploy */
    func view_deploy() { }
    
    // MARK: - Massage
    
    /** Cell Index Path */
    var index: IndexPath!
    /** Cell's tableview's controller */
    weak var controller: ViewController?
    
    /** Cell Update */
    func view_update(index: IndexPath, controller: ViewController?) {
        self.index = index
        self.controller = controller
        if !is_loaded {
            view_load()
            is_loaded = true
        }
        view_reload()
    }
    
    // MARK: - Loads
    private var is_loaded = false
    /** */
    func view_load() { }
    /** */
    func view_reload() { }

}
