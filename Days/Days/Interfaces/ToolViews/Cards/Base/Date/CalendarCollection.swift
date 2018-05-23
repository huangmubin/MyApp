//
//  CalendarCollection.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

protocol CalendarCollectionDelegate: class {
    func calendarCollection(view: CalendarCollection, update_cell cell: CalendarCollectionCell)
    func calendarCollection(view: CalendarCollection, select_cell cell: CalendarCollectionCell)
}

class CalendarCollection: View, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Values
    
    /** 日期 */
    private var date: Date = Date()
    
    /** first data at calender */
    var first: Date = Date()
    
    /** Size */
    var size: CGSize = CGSize(
        width: (UIScreen.main.bounds.width - 40) / 7,
        height: (UIScreen.main.bounds.width - 40) / 7
    )
    
    /***/
    weak var delegate: CalendarCollectionDelegate?
    
    // MARK: - Override
    
    /** Update the cell status */
    private func days_update(cell: CalendarCollectionCell) {
        let day = cell.date!
        if day.month == date.month { // 当月
            // 天数，文本颜色，选中图
            if day.day == date.day {
                select_day = cell
                cell.select.isHidden = false
            } else {
                cell.select.isHidden = true
            }
        } else { // 其他月份
            cell.select.isHidden = true
        }
        cell.day.text = "\(first.advance(.day, cell.index.row).day)"
        days_update_color(cell: cell)
        delegate?.calendarCollection(view: self, update_cell: cell)
    }
    
    /** Override */
    func days_update_color(cell: CalendarCollectionCell) { }
    
    /** Override */
    func days_select(cell: CalendarCollectionCell) { }
    
    /**  */
    func update(date: Date) {
        self.date = date
        self.first = date.first(.month).first(.weekday)
        self.calendar?.reloadData()
    }
    
    // MARK: - Collection
    
    /** Collection */
    @IBOutlet weak var calendar: UICollectionView! {
        didSet {
            calendar.register(UINib(nibName: "CalendarCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        }
    }
    
    /** current select day */
    weak var select_day: CalendarCollectionCell?
    
    /**  */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCollectionCell
        cell.index = indexPath
        cell.date = first.advance(.day, indexPath.row)
        days_update(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let new = first.advance(.day, indexPath.row)
        if new.month == date.month {
            if new.day != date.day {
                date = new
                days_update(cell: select_day!)
                days_update(cell: calendar.cellForItem(at: indexPath) as! CalendarCollectionCell)
                days_select(cell: select_day!)
                delegate?.calendarCollection(view: self, select_cell: select_day!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }

}

// MARK: - Collection Cell

final class CalendarCollectionCell: UICollectionViewCell {
    
    // MARK: - Data
    
    /** Index Path */
    var index: IndexPath!
    /** Date */
    var date: Date!
    
    // MARK: - SubView
    
    /** 日期 */
    @IBOutlet weak var day: UILabel!
    /** 背景 */
    @IBOutlet weak var back: View!
    /** 选中状态 */
    @IBOutlet weak var select: View! {
        didSet {
            select.backgroundColor = Color.gray_dark
        }
    }
    
}
