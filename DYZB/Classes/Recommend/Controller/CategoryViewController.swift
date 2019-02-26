//
//  CategoryViewController.swift
//  DYZB
//
//  Created by jyd on 2019/2/26.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

 // MARK: - 常量
private let CollectionCellID = "CollectionCellID"
private let CollectionHeaderID = "CollectionHeaderID"
private let CollectionFooterID = "CollectionFooterID"

class CategoryViewController: UIViewController {

     // MARK: - 属性
    private var dataArr: [String] =  [String]()
    
    
     // MARK: - 懒加载
    private lazy var collectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenW / 4, height:  kScreenW / 4)
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: 40)
        flowLayout.footerReferenceSize = CGSize(width: kScreenW, height: 20)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    
        
        
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionCellID)
        collectionView.register(UINib(nibName: "CategoryCollectionReusableView", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooterID)
        
        return collectionView
        
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl.init()
        pageControl.hidesForSinglePage = true
        pageControl.frame = CGRect(origin: .zero, size: CGSize(width: kScreenW, height: 10))
        return pageControl
    }()
    
    
     // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    
}

 // MARK: - UI
extension CategoryViewController {
    private func setupUI() {
        self.view.addSubview(collectionView)
        
    }
}

 // MARK: - 数据
extension CategoryViewController {
    private func loadData() {
        for _ in 0..<10 {
            
        }
    }
}


 // MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView: UICollectionReusableView
        if kind == "UICollectionElementKindSectionHeader" {
             reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderID, for: indexPath)
        } else {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionFooterID, for: indexPath)
            reusableView.backgroundColor = UIColor.lightGray
        
        }
        
       

        return reusableView
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 8
        } else if section == 2 {
           
            return 15
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellID, for: indexPath)
        
        return cell
    }
    
    
}

