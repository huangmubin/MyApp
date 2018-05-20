//
//  CardChartView.swift
//  Days
//
//  Created by Myron on 2018/5/20.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardChartView: CardView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var chart: Chart!
    
    // MARK: - Formatter
    
    static let format = DateFormatter("yyyy.MM.dd")
    var format: DateFormatter { return CardChartView.format }
    
    // MARK: - Reload
    
    override func reload() {
        name_label.text = chart.value.name
        note_label.text = chart.value.note
        goal_label.text = chart.value.goal.description
        goal_layout.constant = -collection.bounds.height / 2
        update_date_label()
        
        let h = max(note_label.sizeThatFits(note_label.bounds.size).height, 20) + 90
        if navigation_layout.constant != h {
            UIView.animate(withDuration: 0.25, animations: {
                self.navigation_layout.constant = h
                self.frame.size.height = 160 + h
                self.layoutIfNeeded()
                self.table.update_content_size()
            })
        }
    }
    
    // MARK: - Navigation
    
    @IBOutlet weak var navigation_layout: NSLayoutConstraint!
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var note_label: UILabel!
    
    @IBAction func log_action(_ sender: UIButton) {
        append_action()
    }
    
    /** Override */
    func append_action() {}
    
    @IBAction func edit_action(_ sender: UIButton) {
        open_edit_action()
    }
    
    /** Override */
    func open_edit_action() {}
    
    // MARK: - Goal
    
    @IBOutlet weak var goal_image: UIImageView!
    
    @IBOutlet weak var goal_label: UILabel!
    @IBOutlet weak var goal_layout: NSLayoutConstraint!
    
    // MARK: - Collections
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.register(UINib(nibName: "CardChartCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chart?.units.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardChartCollectionCell
        let unit = chart.units[indexPath.row]
        cell.update(
            title: "\(unit.value.date % 100)",
            progress: max(CGFloat(unit.value.length) / CGFloat(chart.value.goal), 1.5)
        )
        return cell
    }
    
    // MARK: - Date
    
    @IBOutlet weak var date_label: UILabel!
    
    func update_date_label() {
        if let range = chart?.date_range() {
            date_label.text = "\(format.string(from: range.0)) - \(format.string(from: range.1))"
        }
    }
    
    @IBAction func last_date_action(_ sender: UIButton) {
        chart.update(
            date: chart.date.advance(chart.value.is_month ? .month : .weekday, -1)
        )
        update_date_label()
    }
    @IBAction func next_date_action(_ sender: UIButton) {
        chart.update(
            date: chart.date.advance(chart.value.is_month ? .month : .weekday, 1)
        )
        update_date_label()
    }
    
    
}
