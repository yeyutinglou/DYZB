//
//  PageContentView.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/24.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit
// MARK: - 定义协议
protocol PageContenViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

// MARK: - 定义常量
private let ContentCellID = "ContentCellID"

// MARK: - 定义PageContentView类
class PageContentView: UIView {

    // MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContenViewDelegate?
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {[weak self] in
        //创建layOut
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - UI
extension PageContentView {
    private func setupUI() {
        //子视图添加到父视图
        for childvc in childVcs {
            parentViewController?.addChild(childvc)
        }
        
        //添加collectionView
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}


// MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PageContentView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isForbidScrollDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { //左滑
            //计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int (currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { //右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int (currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        
        }
        
//        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
        
    }
    
}

// MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        
        isForbidScrollDelegate = true
        
        let offSetX = CGFloat(currentIndex) * self.bounds.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
