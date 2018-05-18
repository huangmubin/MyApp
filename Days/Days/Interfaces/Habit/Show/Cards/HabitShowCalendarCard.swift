//
//  HabitShowCalendarCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowCalendarCard: CardView, KeyboardDateInputDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func reload() {
        self.date_button.setTitle(
            DateFormatter("yyyy 年 M 月 d 号").string(from: date),
            for: .normal
        )
        collection.reloadData()
        first = date.first(.month).first(.weekday)
    }
    
    // MARK: - Date Select
    
    @IBOutlet weak var date_button: UIButton!
    @IBAction func date_action(_ sender: UIButton) {
        if let view = KeyboardDateInput.load(nib: nil) {
            view.date_delegate = self
            view.year_view.text = date.year.description
            view.month_view.text = date.month.description
            view.day_view.text = date.day.description
            view.year_view.old = date.year.description
            view.month_view.old = date.month.description
            view.day_view.old = date.day.description
            view.day_view.max = date.days(.month)
            print(view.day_view.max)
            view.push()
        }
    }
    
    func keyboard_date(_ view: KeyboardDateInput, year: Int, month: Int, day: Int) {
        date = DateFormatter("yyyy-M-d").date(from: "\(year)-\(month)-\(day)")!
        first = date.first(.month).first(.weekday)
        date_button.setTitle(
            "\(year) 年 \(month) 月 \(day) 号",
            for: .normal
        )
        collection.reloadData()
    }
    
    // MARK: - Open Calendar
    
    @IBOutlet weak var calender_button: Button!
    
    @IBAction func calendar_action(_ sender: Button) {
        let h = self.frame.size.height == 60 ? (40 + UIScreen.main.bounds.width) : 60
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.size.height = h
            self.table.update_content_size()
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Collection

    @IBOutlet weak var collection: UICollectionView!
    
    /** current select day */
    weak var select_day: HabitShowCalendarCardCell?
    
    /** first data at calender */
    var first: Date = Date()
    
    /** Size */
    var size: CGSize = CGSize(
        width: (UIScreen.main.bounds.width - 40) / 7,
        height: (UIScreen.main.bounds.width - 40) / 7
    )
    
    /**  */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitShowCalendarCardCell
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
                self.date_button.setTitle(
                    DateFormatter("yyyy 年 M 月 d 号").string(from: date),
                    for: .normal
                )
                days_update(cell: select_day!)
                days_update(cell: collection.cellForItem(at: indexPath) as! HabitShowCalendarCardCell)
            }
        }
    }
    
    /** Update the cell status */
    func days_update(cell: HabitShowCalendarCardCell) {
        let day = cell.date!
        if day.month == date.month { // 当月
            // 天数，文本颜色，选中图
            if day.day == date.day {
                select_day = cell
                cell.select.isHidden = false
            } else {
                cell.select.isHidden = true
            }
            // 状态，背景图
            if let status = habit.status(at_date: day.date) {
                if status == 0 {
                    cell.day.textColor = Color.gray_dark
                    cell.back.backgroundColor = Color.white
                    cell.select.backgroundColor = Color.gray_dark
                } else {
                    cell.day.textColor = Color.white
                    cell.back.backgroundColor = habit.color()
                    cell.select.backgroundColor = Color.white
                }
            } else {
                cell.day.textColor = Color.gray_dark
                cell.back.backgroundColor = Color.gray_light
                cell.select.backgroundColor = Color.gray_dark
            }
        } else { // 其他月份
            cell.day.textColor = Color.gray_light
            cell.select.isHidden = true
            cell.back.backgroundColor = Color.white
        }
        cell.day.text = "\(first.advance(.day, cell.index.row).day)"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
    
}

// MARK: - Collection Cell

class HabitShowCalendarCardCell: UICollectionViewCell {
    
    // MARK: - Data
    
    public var index: IndexPath!
    public var date: Date!
    
    // MARK: - SubView
    
    /** 日期 */
    @IBOutlet weak var day: UILabel!
    /** 背景 */
    @IBOutlet weak var back: View!
    /** 选中状态 */
    @IBOutlet weak var select: View!
    
    
}
