//
//  HorizontalCollectionFlowLayout.swift
//  DYZB
//
//  Created by jyd on 2019/3/1.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

class HorizontalCollectionFlowLayout: UICollectionViewFlowLayout {

     // MARK: - 定义属性
    //列数
    var column = 4
    //行数
    var line = 3
    
    //contentSize的最大宽度
    private var maxWith: CGFloat = 0
    
     // MARK: - 懒加载
    private lazy var layoutAttributeArray: [UICollectionViewLayoutAttributes] = []
    
}

 // MARK: - 重写方法
extension HorizontalCollectionFlowLayout {
    
    override func prepare() {
        super.prepare()
        //item的位置
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat (column - 1)) / CGFloat(column)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(line - 1)) / CGFloat(line)
        
        let sections = collectionView?.numberOfSections
        var pageCount: Int = 0
        
        for i in 0..<sections! {
            let items = collectionView?.numberOfItems(inSection: i)
            for j in 0..<items! {
                let indexPath = IndexPath(item: j, section: i)
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let page = j / (column * line)
                let index = j % (column * line)
                let itemX = sectionInset.left + CGFloat(pageCount  + page) * collectionView!.bounds.width + (itemW + minimumInteritemSpacing) * CGFloat(index % column)
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat (index / column)
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                layoutAttributeArray.append(attr)
                
            }
            pageCount += (items! - 1) / (column * line) + 1
            
        }
        maxWith = CGFloat(pageCount) * collectionView!.bounds.width
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //取出相交的位置
        return layoutAttributeArray.filter {$0.frame.intersects(rect)}
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWith, height: 0)
    }
    
}
