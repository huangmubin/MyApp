//
//  Show.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/9.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension Habit {
    class Show {
        
        // MARK: - Init
        
        /** 所属 Habit */
        weak var obj: Habit!
        init(habit: Habit) {
            obj   = habit
            flags = obj.flags
        }
        
        /** 释放内存 */
        func clear() {
            flag_cell.removeAll()
        }
        
        // MARK: - Flags
        
        /** 标签列表 */
        var flags: [String] = []
        
        /** 根据下标获取 */
        func flag(_ index: IndexPath) -> String {
            return flags[index.row]
        }
        
        // MARK: - Heights
        
        /**  */
        var heights: [CGFloat] = []
        
        /**  */
        func height(_ index: IndexPath) -> CGFloat {
            return heights[index.row]
        }
        
        // MARK: - Cells
        
        /**  */
        private var flag_cell: [String: HabitShowCell] = [:]
        
        /**  */
        func cell(table: UITableView, index: IndexPath) -> HabitShowCell {
            if let c = flag_cell[flags[index.row]] {
                return c
            } else {
                let c = table.dequeueReusableCell(withIdentifier: flags[index.row], for: index) as! HabitShowCell
                flag_cell[flags[index.row]] = c
                return c
            }
        }
        
        // MARK: - Date
        
        /** 当前时间 */
        var date: Date = Date()
        
    }
}

