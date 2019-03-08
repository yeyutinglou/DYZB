//
//  ChildRecommendViewController.swift
//  DYZB
//
//  Created by jyd on 2019/3/7.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit


fileprivate let kItemH: CGFloat = 160
fileprivate let kMargin: CGFloat = 10
fileprivate let kItemW: CGFloat = (kScreenW - 3 * kMargin) / 2
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kCircleH: CGFloat = 200

class ChildRecommendViewController: UIViewController {

     // MARK: - 懒加载
    lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = kMargin
        layout.minimumInteritemSpacing = kMargin
        
        let collection = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        collection.contentInset = UIEdgeInsets(top: 0, left:kMargin , bottom: 0, right: kMargin)
        collection.dataSource = self
        collection.register(UINib(nibName: "NormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        return collection
    }()
    
    lazy var circleView: CircleView = {
        let circle = CircleView.circleView()
        circle.frame = CGRect(x: 0, y: -kCircleH, width: kScreenW, height: kCircleH)
        return circle
    }()
    
     // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()

    }
    

  

}

 // MARK: - UI
extension ChildRecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.addSubview(circleView)
        collectionView.contentInset = UIEdgeInsets(top: kCircleH, left: 0, bottom: 0, right: 0)
    }
}

 // MARK: - UICollectionViewDataSource协议
extension ChildRecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        return cell
        
    }
    
    
}
