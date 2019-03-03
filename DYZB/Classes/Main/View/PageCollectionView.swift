//
//  PageCollectionView.swift
//  DYZB
//
//  Created by jyd on 2019/2/27.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kPageControlH: CGFloat = 20
private let kMaxNum = 12
private let kCollectionID = "kCollectionID"

class PageCollectionView: UIView {

     // MARK: - 属性
    private var category: [Int]
    //是否显示pageControl
    private var isPageHide: Bool = false
    //sections  总页数
    private var pageCount = 0
   
    private let flowLayout: HorizontalCollectionFlowLayout
    
    
    
    
     // MARK: - 懒加载
    private lazy var collectionView: UICollectionView =  {
        
       

        flowLayout.column = 4
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        flowLayout.scrollDirection = .horizontal
        
        
        let collectionFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - (isPageHide ? kPageControlH : 0))
        let collectionView = UICollectionView(frame:collectionFrame, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionID)
        
        
        return collectionView
        
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pageControl.backgroundColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.numberOfPages = 10
        return pageControl
    }()
    
     // MARK: - 构造方法
    init(frame: CGRect, category: [Int]) {
        self.category = category
        flowLayout = HorizontalCollectionFlowLayout()
       
        let count = category.count
        var line = 0
        if count >= kMaxNum {
            line = 3
        } else {
            line = count % 4 == 0 ? count / 4  : count / 4 + 1
        }
        flowLayout.line = line
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


 // MARK: - UI
extension PageCollectionView {
    private func setupUI() {
        addSubview(collectionView);
        addSubview(pageControl)
    }
    
    override func layoutSubviews() {
        pageControl.frame = CGRect(origin:CGPoint(x: 0, y: self.bounds.height - kPageControlH), size: CGSize(width: kScreenW, height: kPageControlH))
    }
}


 // MARK: - UICollectionViewDataSource代理
extension PageCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         pageCount = category.count % kMaxNum == 0 ? category.count / kMaxNum : category.count / kMaxNum + 1
         isPageHide = pageCount == 0 ? true : false
        pageControl.numberOfPages = pageCount
//        pageControl.isHidden = isPageHide
        
        return pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = category.count - (section * kMaxNum)
        let items = count >= kMaxNum ? kMaxNum : (count  % kMaxNum)
        
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
    
}

 // MARK: - UICollectionViewDelegateFlowLayout协议
extension PageCollectionView: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offSetX / collectionView.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + pageControl.currentPage * kMaxNum)
    }
}
