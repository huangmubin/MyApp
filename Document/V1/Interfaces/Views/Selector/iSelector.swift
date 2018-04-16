//
//  iSelector.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

protocol i_SelectorDelegate: class {
    func i_selector(_ iSel: iSelector, update_index index: Int)
}

class iSelector: View, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(direction: UICollectionViewScrollDirection) {
        self.init(frame: CGRect.zero)
        self.direction = direction
    }
    
    // MARK: - Data
    
    /** 数据 */
    var data: [String] = iSelector.months(5)
    
    /** 当前选中的数据 */
    var current: String { return data[index] }
    /** 当前选中数据的 Int */
    var int: Int { return Int(current) ?? 0 }
    
    /** 尺寸 */
    var size: CGSize = CGSize.zero
    
    // MARK: Index
    
    /** scroll view's index */
    var index_scroll: Int {
        switch direction {
        case .vertical:
            if size.height > 0 {
                return Int(collection.contentOffset.y / size.height + 0.5)
            } else {
                return 0
            }
        case .horizontal:
            if size.width > 0 {
                return Int(collection.contentOffset.x / size.width + 0.5)
            } else {
                return 0
            }
        }
    }
    
    /** data_index */
    var index: Int { return index_scroll + (cells - 1) / 2 }
    
    // MARK: Delegate
    
    @IBOutlet weak var i_delegate: NSObject! {
        didSet {
            if let i = i_delegate as? i_SelectorDelegate {
                delegate = i
            }
        }
    }
    weak var delegate: i_SelectorDelegate?
    
    // MARK: IB
    
    /** Scroll Direction */
    @IBInspectable var i_direction: Bool = true {
        didSet { direction = i_direction ? .vertical : .horizontal }
    }
    /** Scroll Direction */
    var direction: UICollectionViewScrollDirection = .vertical {
        didSet {
            update_direction()
            layout.scrollDirection = direction
        }
    }
    
    /** Label */
    @IBOutlet var label: UILabel! = nil {
        didSet {
            label.removeFromSuperview()
            collection?.reloadData()
        }
    }
    
    /** year month day hour minute */
    @IBInspectable var default_data: Int = 0 {
        didSet {
            switch default_data {
            case 0: data = iSelector.years(cells)
            case 1: data = iSelector.months(cells)
            case 2: data = iSelector.days(cells, year: Date().year, month: Date().month)
            case 3: data = iSelector.hours(cells)
            case 4: data = iSelector.minutes(cells)
            default: break
            }
        }
    }
    
    /** Cells */
    @IBInspectable var cells: Int = 5 {
        didSet {
            if oldValue == 5 && cells == 3 {
                data.removeLast()
                data.removeFirst()
            }
            update_direction()
            collection.reloadData()
        }
    }
    
    // MARK: - Gradient
    
    /** gradien view */
    private var gradient_view: UIView = UIView()
    /** gradien layer */
    private var gradient: CAGradientLayer = CAGradientLayer()
    /** gradien color */
    @IBInspectable var gradient_color: UIColor = UIColor.white {
        didSet {
            gradient.colors = [gradient_color.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, gradient_color.cgColor]
            gradient.setNeedsDisplay()
        }
    }
    
    // MARK: - Deploy
    
    override func view_deploy() {
        super.view_deploy()
        // Laber
        if label == nil {
            label = UILabel()
            label.font = UIFont(name: "PingFangSC-Thin", size: 24)
            label.textAlignment = .center
            label.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1)
        }
        
        // Layout
        switch direction {
        case .vertical:
            size = CGSize(width: self.bounds.width, height: self.bounds.height / CGFloat(cells))
        case .horizontal:
            size = CGSize(width: self.bounds.width / CGFloat(cells), height: self.bounds.height)
        }
        
        layout.scrollDirection = direction
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // Collection
        collection = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.backgroundColor = UIColor.clear
        addSubview(collection)
        
        // Gradien
        addSubview(gradient_view)
        gradient_view.frame = bounds
        gradient_view.backgroundColor = UIColor.clear
        gradient_view.isUserInteractionEnabled = false
        gradient.frame = bounds
        gradient.colors = [gradient_color.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, gradient_color.cgColor]
        gradient.locations = [0, 0.5, 1]
        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradient_view.layer.addSublayer(gradient)
    }
    
    // MARK: - Frame
    
    override func view_bounds() {
        super.view_bounds()
        update_direction()
        collection.frame = bounds
        gradient_view.frame = bounds
        gradient.frame = bounds
    }
    
    private func update_direction() {
        switch direction {
        case .vertical:
            size = CGSize(width: self.bounds.width, height: self.bounds.height / CGFloat(cells))
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            size = CGSize(width: self.bounds.width / CGFloat(cells), height: self.bounds.height)
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradient.setNeedsDisplay()
    }
    
    // MARK: - Collection
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var collection: UICollectionView!
    
    /** Reload */
    func reload() { collection.reloadData() }
    
    /** Scroll */
    func scroll(data: String, animate: Bool) {
        print("scroll \(data) collection = \(collection.contentSize)")
        if let i = self.data.index(of: data) {
            collection.scrollToItem(at: IndexPath(row: i - (cells - 1) / 2, section: 0), at: UICollectionViewScrollPosition.top, animated: animate)
        }
    }
    
    /** Scroll */
    func scroll(i: Int, animate: Bool) {
        if i + 2 < data.count {
            collection.scrollToItem(at: IndexPath(row: i, section: 0), at: UICollectionViewScrollPosition.top, animated: animate)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if cell.tag != 10 {
            let label = UILabel()
            label.tag = 100
            label.font = self.label.font
            label.textColor = self.label.textColor
            label.textAlignment = self.label.textAlignment
            cell.tag = 10
            cell.contentView.addSubview(label)
        }
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = data[indexPath.row]
            label.frame = cell.bounds
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
    
    // MARK: - Scroll
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var i: Int
        switch direction {
        case .vertical:
            i = Int(scrollView.contentOffset.y / size.height + 0.5)
            scrollView.setContentOffset(
                CGPoint(x: 0, y: CGFloat(i) * size.height),
                animated: true
            )
        case .horizontal:
            i = Int(scrollView.contentOffset.x / size.width + 0.5)
            scrollView.setContentOffset(
                CGPoint(x: CGFloat(i) * size.width, y: 0),
                animated: true
            )
        }
        delegate?.i_selector(self, update_index: i)
    }
}


// MARK: - Datas

extension iSelector {
    static let format = DateFormatter()
    
    // MARK: - Days
    
    static func space(_ cells: Int) -> [String] {
        let c = (cells - 1) / 2
        var space = [String]()
        for _ in 0 ..< c {
            space.append("")
        }
        return space
    }
    
    static func months(_ cells: Int) -> [String] {
        var strs = space(cells)
        for i in 1 ..< 13 {
            strs.append("\(i)")
        }
        return strs + space(cells)
    }
    
    static func years(_ cells: Int) -> [String] {
        var strs = space(cells)
        for i in 2018 ..< 2118 {
            strs.append("\(i)")
        }
        return strs + space(cells)
    }
    
    static func days(_ cells: Int, year: Int, month: Int) -> [String] {
        format.dateFormat = "yyyy-M-d"
        var strs = space(cells)
        if let date = format.date(from: "\(year)-\(month)-1") {
            for i in 1 ... date.days_in_month {
                strs.append("\(i)")
            }
        }
        return strs + space(cells)
    }
    
    static func hours(_ cells: Int) -> [String] {
        var strs = space(cells)
        for i in 1 ..< 24 {
            strs.append("\(i)")
        }
        return strs + space(cells)
    }
    
    static func minutes(_ cells: Int) -> [String] {
        var strs = space(cells)
        for i in 1 ..< 60 {
            strs.append("\(i)")
        }
        return strs + space(cells)
    }
    
}
