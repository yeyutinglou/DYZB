//
//  CircleView.swift
//  DYZB
//
//  Created by jyd on 2019/3/7.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

fileprivate let kCollectionCell = "kCollectionCell"
fileprivate let kImageCount = 6


class CircleView: UIView {

   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate var layout: UICollectionViewFlowLayout!
    fileprivate var timer: Timer?
    fileprivate var isTimer: Bool = true
    
    override func awakeFromNib() {
        autoresizingMask = .init(rawValue: 0)
        layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        
        
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionCell)
        
        pageControl.numberOfPages = kImageCount
        pageControl.currentPage = 0
        collectionView.contentOffset = CGPoint(x: CGFloat(kImageCount * 20) * kScreenW, y: 0)
         addTimer()
        
        
    }
    override func layoutSubviews() {
        layout.itemSize = self.bounds.size
    }
    
}

 // MARK: - UICollectionViewDataSource协议
extension CircleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kImageCount * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath)
        
        for view in cell.contentView.subviews {
            view .removeFromSuperview()
        }
        
        let imageView = UIImageView()
        imageView.frame = cell.contentView.bounds
        imageView.backgroundColor = UIColor.randomColor()
        cell.contentView.addSubview(imageView)
        
        return cell
        
    }
    
}

 // MARK: - UICollectionViewDelegateFlowLayout协议
extension CircleView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         removeTimer()
        isTimer = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isTimer {
            return
        }
        let offsetX = scrollView.contentOffset.x
            pageControl.currentPage = Int(offsetX / collectionView.bounds.width) % kImageCount
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
       addTimer()
    
    }
    
}

 // MARK: - timer
extension CircleView {
    func addTimer() {
        
        timer = Timer(timeInterval: 2, target: self, selector: #selector(scrollImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer?.fire()
        
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
}

 // MARK: - 私有方法
extension CircleView {
    
    @objc func scrollImage() {
        let offsetX = collectionView.contentOffset.x
       
        collectionView.setContentOffset(CGPoint(x: offsetX + kScreenW, y: 0), animated: true)
        pageControl.currentPage = (pageControl.currentPage + 1) % kImageCount
    }
}




 // MARK: - 实例化
extension CircleView {
    class func circleView() -> (CircleView) {
        return Bundle.main.loadNibNamed("CircleView", owner: nil, options: nil)?.first as! (CircleView)
    }
}
