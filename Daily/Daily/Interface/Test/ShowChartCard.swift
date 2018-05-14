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
    
    var chart: Habit.Chart!
    
    // MARK: - Name
    
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Date
    
    @IBOutlet weak var date: UILabel!
    
    @IBAction func last_date_action(_ sender: UIButton) {
    }
    @IBAction func next_date_action(_ sender: UIButton) {
    }
    
    // MARK: - Chart
    
    @IBOutlet weak var collection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
        return cell
    }
    
}


// MARK: - Chart Cell

class ShowChartCardCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var animate: UIView!
    
    
    
}


