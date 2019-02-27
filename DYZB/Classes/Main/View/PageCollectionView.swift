//
//  PageCollectionView.swift
//  DYZB
//
//  Created by jyd on 2019/2/27.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

class PageCollectionView: UIView {

     // MARK: - 属性
    private var category: [Int]
    
     // MARK: - 懒加载
    private lazy var collectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenW / 4, height:  kScreenW / 4)
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: 40)
        flowLayout.footerReferenceSize = CGSize(width: kScreenW, height: 20)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        
        
        let collectionView = UICollectionView(frame:self.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        return collectionView
        
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl.init()
        pageControl.hidesForSinglePage = true
        pageControl.frame = CGRect(origin: .zero, size: CGSize(width: kScreenW, height: 10))
        return pageControl
    }()
    
     // MARK: - 构造方法
    init(frame: CGRect, category: [Int]) {
        self.category = category
        
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
    }
}


 // MARK: - UICollectionViewDataSource代理
extension PageCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

 // MARK: - UICollectionViewDelegateFlowLayout协议
extension PageCollectionView: UICollectionViewDelegateFlowLayout {
    
}
