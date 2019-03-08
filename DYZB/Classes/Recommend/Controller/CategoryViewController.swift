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
private let kPageItemH: CGFloat = 80
//private let kItemMargin = 10
//private let kPageControlH = 20

class CategoryViewController: BaseViewController {

     // MARK: - 属性
    private var dataArr: [[Int]] =  [[Int]]()
    
    
     // MARK: - 懒加载
//    private lazy var pageCollectionView: PageCollectionView = {
//        var arr: [Int] = []
//        for i in 0..<12 {
//            arr.append(i)
//        }
//
//        let pageView: PageCollectionView = PageCollectionView(frame: self.view.bounds, category: arr)
//        pageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        return pageView
//
//
//    }()
    private lazy var collectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: kScreenW / 4, height:  kScreenW / 4)
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: 40)
        flowLayout.footerReferenceSize = CGSize(width: kScreenW, height: 10)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    
        
        
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
//        collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionCellID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionCellID)
        collectionView.register(UINib(nibName: "CategoryCollectionReusableView", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooterID)
        
        return collectionView
        
    }()
    

    
    
     // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //UI
        setupUI()
        
        //数据
        loadData()
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
        for _ in 0..<5 {
             var arr: [Int] = [Int]()
            for j in 0..<Int(arc4random_uniform(20)){
                arr.append(j)
            }
            dataArr.append(arr)
        }
        collectionView.reloadData()
    }
}


 // MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArr.count
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
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view .removeFromSuperview()
        }
        
        let category = dataArr[indexPath.section]
        let pageView = PageCollectionView(frame: cell.contentView.bounds, category: category)
        cell.contentView.addSubview(pageView)
        
        return cell
    }
    
    
}

 // MARK: - 遵守UICollectionViewDelegateFlowLayout协议
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //这里为了统一PageCollectionView里面item的高度 需要根据高度计算 cell.contentView的高度
        var cellH = 0
        let items = dataArr[indexPath.section]
        if items.count > 12 {
            cellH = 3 * Int(kPageItemH + kCategoryItemMargin)  + Int(kPageControlH)
        } else {
            let line = items.count % 4 == 0 ? items.count / 4 :  items.count / 4 + 1
            cellH =  Int(kPageItemH + kCategoryItemMargin)  * line 
        }
        return CGSize(width: kScreenW, height: CGFloat(cellH))
    }
    
    
}

