//
//  CardChartView.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardChartView: DaysCardView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Data
    
    /** Chart */
    var chart: Chart!
    
    // MARK: Format
    
    /** Date format yyyy.MM.dd */
    static let format = DateFormatter("yyyy.MM.dd")
    /** Date format yyyy.MM.dd */
    var format: DateFormatter { return CardChartView.format }

    // MARK: Height
    
    /** Height */
    static let height_collection: CGFloat = 160
    /** Height */
    static let height_top: CGFloat = 90
    /** Height */
    static let height_bottom: CGFloat = 60
    
    // MARK: Size
    
    /** Size */
    var size: CGSize {
        return CGSize(
            width: (bounds.width - 40) / CGFloat(chart.units.count),
            height: CardChartView.height_collection
        )
    }
    
    // MARK: - Reload
    
    override func view_bounds() {
        print("view_bounds = \(frame.height)")
    }
    
    /**  */
    override func reload() {
        name_label.text = chart.value.name
        note_label.text = chart.value.note
        let height_top = max(CardChartView.height_top, note_label.sizeThatFits(note_label.bounds.size).height)
        
        if chart.habit.value.is_time {
            goal_label.text = Habit.format(time: chart.value.goal)
        } else {
            goal_label.text = "\(chart.value.goal)次"
        }
        goal_center_layout.constant = (CardChartView.height_collection - 14) / 3 * 2 + 14
        
        update_date_range_label()
        print("height_top = \(height_top) = \(height_top + CardChartView.height_collection + CardChartView.height_bottom) = \(goal_center_layout.constant)")
        print("frame = \(self.frame.height)")
        if self.frame.height != height_top + CardChartView.height_collection + CardChartView.height_bottom {
            UIView.animate(withDuration: 0.25, animations: {
                self.top_height_layout.constant = height_top
                self.collection_height_layout.constant = CardChartView.height_collection
                self.frame.size.height = height_top + CardChartView.height_collection + CardChartView.height_bottom
                self.table.update_content_size()
                self.layoutIfNeeded()
            }, completion: nil)
        }
        
        collection.reloadData()
    }
    
    // MARK: - Top
    
    @IBOutlet weak var top_height_layout: NSLayoutConstraint!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var note_label: UILabel!
    @IBOutlet weak var append_button: UIButton!
    
    /** Override */
    @IBAction func append_action(_ sender: UIButton) { }
    
    /** Override */
    @IBAction func edit_action(_ sender: UIButton) {
    }
    
    // MARK: - Collections
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collection_height_layout: NSLayoutConstraint!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chart.units.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardChartCollectionCell
        let unit = chart.units[indexPath.row]
        let title_show = (chart.units.count > 10) ? (indexPath.row % 2 == 0) : true
        cell.update(
            title: title_show ? "\(unit.value.date % 100)" : "",
            progress: min(CGFloat(unit.value.length) / CGFloat(chart.value.goal), 1.5),
            size: size
        )
        print("\(unit.value.date) : \(unit.value.length) - \(chart.value.goal)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
    
    // MARK: - Goal Image
    
    @IBOutlet weak var goal_label: UILabel!
    @IBOutlet weak var goal_center_layout: NSLayoutConstraint!
    
    // MARK: - Bottom
    
    @IBOutlet weak var date_range_label: UILabel!
    
    /** 更新范围图标 */
    func update_date_range_label() {
        if let range = chart?.date_range() {
            date_range_label.text = "\(format.string(from: range.0)) - \(format.string(from: range.1))"
        }
    }
    
    @IBAction func last_date_action(_ sender: UIButton) {
        chart.update(
            date: chart.date.advance(chart.value.is_month ? .month : .weekday, -1)
        )
        collection.reloadData()
        update_date_range_label()
    }
    
    @IBAction func next_date_action(_ sender: UIButton) {
        chart.update(
            date: chart.date.advance(chart.value.is_month ? .month : .weekday, 1)
        )
        collection.reloadData()
        update_date_range_label()
    }

    
}
