//
//  ShowChartCard.swift
//  Daily
//
//  Created by Myron on 2018/5/11.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ShowChartCard: CardView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - obj
    
    var chart: Chart!
    
    // MARK: - Name
    
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Date
    
    @IBOutlet weak var date: UILabel!
    
    @IBAction func last_date_action(_ sender: UIButton) {
    }
    @IBAction func next_date_action(_ sender: UIButton) {
    }
    
    // MARK: - Chart
    
    @IBOutlet weak var chart: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cha
    }
    
}


// MARK: - Chart Cell

class ShowChartCardCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var animate: UIView!
    
    
    
}


