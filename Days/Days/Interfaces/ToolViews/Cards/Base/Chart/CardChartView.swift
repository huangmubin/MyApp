//
//  CardChartView.swift
//  Days
//
//  Created by Myron on 2018/5/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class CardChartView: DaysCardView {

    // MARK: - Data
    
    /** Chart */
    var chart: Chart = Chart()
    
    // MARK: Format
    
    /** Date format yyyy.MM.dd */
    static let format = DateFormatter("yyyy.MM.dd")
    /** Date format yyyy.MM.dd */
    var format: DateFormatter { return CardChartView.format }
    
    // MARK: Height
    
    /** Height */
    static var height_collection: CGFloat = 160
    /** Height */
    static var height_top: CGFloat = 90
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
    
    override func layoutSubviews() {
        print("layoutSubviews start = \(frame.height)")
        super.layoutSubviews()
        print("layoutSubviews end = \(frame.height)")
    }
    
    // MARK: - Reload
    
    /** Reload */
    override func reload() {
        
    }
    
    // MARK: - Top
    
    @IBOutlet weak var top_height: NSLayoutConstraint!
    
    // MARK: - Collection
    
    
    
    
}
