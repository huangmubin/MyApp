//
//  CalendarView.swift
//  My
//
//  Created by 黄穆斌 on 2018/4/8.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate: NSObjectProtocol {
    func calendar(update view: CalendarView, date: Date)
    func calendar(open view: CalendarView, logs date: Date)
    func calendar(update view: CalendarView, times date: Date) -> Int
    func calendar(update view: CalendarView, minutes date: Date) -> Int
    func calendar(absent view: CalendarView, date: Date) -> Bool
}

class CalendarView: View, i_SelectorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - CalendarViewDelegate
    
    /** Delegate */
    weak var delegate: CalendarViewDelegate?
    
    // MARK: - Date
    
    private var _current: Date = Date()
    /** 当前选中的日期 */
    var current: Date {
        set {
            _current = newValue
            first = newValue.first_day_in_month()!.first_day_in_week()!
            month = newValue.month
            update_month_button()
            month_selector.update(date: current)
            
            update(times: delegate?.calendar(update: self, times: newValue) ?? 0)
            update(minute: delegate?.calendar(update: self, minutes: newValue) ?? 0)
            
            delegate?.calendar(update: self, date: newValue)
        }
        get { return _current }
    }
    
    /** 当前月份 */
    var month: Int = 0
    
    /** 当前显示的第一个日期 */
    var first: Date = Date()
    /** 偏移后的日期 */
    func offset_date(_ index: Int) -> Date {
        let offset = TimeInterval(index) * 86400
        return first.advance(time: offset)
    }
    
    // MARK: - View
    
    override func view_deploy() {
        super.view_deploy()
    }
    
    override func view_bounds() {
        super.view_bounds()
    }
    
    // MARK: - Month 月份视图
    
    /** 月份格式 */
    let month_format = DateFormatter(format: "yyyy 年 M 月")
    
    /** 月份视图 */
    @IBOutlet weak var month_view: UIView!
    
    /** 月份按钮 */
    @IBOutlet weak var month_button: UIButton!
    
    /** 更新月份按钮内容 */
    func update_month_button() {
        month_button.setTitle(
            month_format.string(from: current),
            for: .normal
        )
    }
    
    /** 月份选择事件 */
    @IBAction func month_select_action() {
        UIView.animate(withDuration: 0.25, animations: {
            self.month_selector_layout.constant = self.is_month_selector_open ? 0 : self.day_view.bounds.height
            self.layoutIfNeeded()
        }, completion: { _ in
            self.day_collection.reloadData()
        })
    }
    /** 选择上一个月 */
    @IBAction func month_select_last_action() {
        current = current.advance_last_month()
        day_collection.reloadData()
        
    }
    /** 选择下一个月 */
    @IBAction func month_select_next_action() {
        current = current.advance_next_month()
        day_collection.reloadData()
    }
    
    // MARK: - Date Selector
    
    @IBOutlet weak var month_selector_view: UIView!
    @IBOutlet weak var month_selector: iDateSelector!
    @IBOutlet weak var month_selector_layout: NSLayoutConstraint!
    
    /** 月份选择器当前是否展开 */
    var is_month_selector_open: Bool { return month_selector_layout.constant != 0 }
    
    // MARK: i_SelectorDelegate
    
    func i_selector(_ iSel: iSelector, update_index index: Int) {
        current = month_selector.date()
    }
    
    // MARK: - Days View
    
    /** 日期选择视图 */
    @IBOutlet weak var day_view: UIView!
    
    // MARK: - Days Collections
    
    /** 当前选中的 Cell */
    weak var select_cell: CalendarCell?
    
    @IBOutlet weak var day_collection: UICollectionView! {
        didSet {
            day_collection.register(UINib(nibName: "CalendarCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCell
        let date = offset_date(indexPath.row)
        cell.update(index: indexPath, view: self)
        cell.label.text = date.day.description
        cell.update(
            show: date.month == month,
            today: date.today == Date().today,
            done: (delegate?.calendar(update: self, times: date) ?? 0) > 0
        )
        cell.is_absent(
            delegate?.calendar(absent: self, date: date) ?? false
        )
        if date.today == current.today {
            cell.select(true)
            select_cell = cell
        } else {
            cell.select(false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width / 7,
            height: collectionView.bounds.height / 5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (select_cell?.index?.row ?? -1) == indexPath.row {
            return
        }
        let new = offset_date(indexPath.row)
        if new.month != month { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell {
            cell.select(true)
            select_cell?.select(false)
            select_cell = cell
            current = new
        }
    }
    
    // MARK: - Control
    
    @IBOutlet weak var control_view: UIView!
    
    /** 打开当天的明细记录 */
    @IBAction func control_open_logs(_ sender: UIButton) {
        delegate?.calendar(open: self, logs: current)
    }
    
    /** 打卡次数 */
    @IBOutlet weak var control_times: UILabel!
    /** 投入时长 */
    @IBOutlet weak var control_minute: UILabel!
    
    /** 按格式更新打卡次数 */
    func update(times: Int) {
        control_times.text = "打卡 \(times) 次"
    }
    /** 按格式更新投入时长 */
    func update(minute: Int) {
        control_minute.text = "投入 \(minute) 分钟"
    }
}

