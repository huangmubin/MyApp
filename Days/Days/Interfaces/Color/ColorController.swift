//
//  ColorController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ColorController: ViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        for value in values {
            colors.append(UIColor(UInt(value)))
        }
    }
    
    // MARK: - Values
    
    var values: [Int] = [
        0x3DAFFD,
        0xFF0035,
        0x50E3C2,
        0x45538C,
        0x3DAFFD,
        0xFF0035,
        0x50E3C2,
        0x45538C,
        0x3DAFFD,
        0xFF0035,
        0x50E3C2,
        0x45538C,
        0x3DAFFD,
        0xFF0035,
        0x50E3C2,
        0x45538C
    ]
    var colors: [UIColor] = []

    // MARK: - Back
    
    @IBAction func back_aciton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Collection
    
    @IBOutlet weak var collection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ColorCell
        cell.color_view.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let s = (UIScreen.main.bounds.width - 60) / 2
        return CGSize(width: s, height: s)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        self.toSuperController(object: ["Color": values[indexPath.row]])
        cell.select_animate(complete: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
