//
//  ImageController.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class ImageController: ViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func image(name: String, color: Int) -> UIImage? {
        return UIImage(contentsOfFile: "\(NSHomeDirectory())/Document/Images/\(value)_\(color).png")
    }
    
    // MARK: - Value
    
    var color: Int = 0
    
    var values: [String] = [
    ]
    var images: [UIImage] = []
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color_data = UIColor(UInt(color))
        for value in values {
            let path = "\(NSHomeDirectory())/Document/Images/\(value)_\(color).png"
            if let image = UIImage(contentsOfFile: path) {
                images.append(image)
            } else if let image = UIImage(named: value) {
                let color_image = image.change(color: color_data)!
                let data = UIImagePNGRepresentation(color_image)!
                try! data.write(to: URL(fileURLWithPath: path))
                images.append(color_image)
            }
        }
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
        let s = (UIScreen.main.bounds.width - 100) / 4
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
