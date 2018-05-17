//
//  ImageController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ImageController: ViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /** 获取颜色对应的 */
    class func image(name: String, color: Int) -> UIImage {
        let path = "\(NSHomeDirectory())/Documents/Images/\(name)_\(color).png"
        if let image = UIImage(contentsOfFile: path) {
            return image
        }
        let image = UIImage(named: name)!
        let color_image = image.change(color: UIColor(UInt(color)))!
        let data = UIImagePNGRepresentation(color_image)!
        try! data.write(to: URL(fileURLWithPath: path))
        return color_image
    }
    
    // MARK: - Value
    
    var color: Int = 0
    
    var values: [String] = [
        "alarm-clock",
        "bicycle",
        "book",
        "computer",
        "cooking",
        "improvement",
        "karaoke",
        "wallet",
        "alarm-clock",
        "bicycle",
        "book",
        "computer",
        "cooking",
        "improvement",
        "karaoke",
        "wallet",
        "alarm-clock",
        "bicycle",
        "book",
        "computer",
        "cooking",
        "improvement",
        "karaoke",
        "wallet",
        "alarm-clock",
        "bicycle",
        "book",
        "computer",
        "cooking",
        "improvement",
        "karaoke",
        "wallet",
    ]
    var images: [UIImage] = []
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for value in values {
            print("image = \(value); color = \(color);")
             images.append(
                ImageController.image(name: value, color: color)
            )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collection.reloadData()
    }
    
    // MARK: - Back
    
    @IBAction func back_aciton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Collection
    
    @IBOutlet weak var collection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        cell.image_view.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let s = min((UIScreen.main.bounds.width - 100) / 4, 60)
        return CGSize(width: s, height: s)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        self.toSuperController(object: ["Image": values[indexPath.row]])
        cell.select_animate(complete: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
