//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/23.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit
import SnapKit

private let kTitleViewH: CGFloat = 50

class RecommendViewController: UIViewController {

    lazy var navigaitonView = CustomNavigationView()
    
    lazy var pageTitleView: PageTitleView = {[weak self] in
        
        let titles = ["分类", "推荐","全部","游戏"]
        
        let titleView = PageTitleView()
        titleView.titles = titles
        titleView.delegate = self
        titleView.backgroundColor = UIColor.orange
        return titleView
        }()
    
    private lazy var pageContentView: PageContentView = {[weak self] in
        //        let contentFrame = CGRect(x: 0, y:kNavigationH + kTitleViewH, width: kScreenW, height: kScreenH - kNavigationH - kTitleViewH - kTabbarH)
        //确定所有子控制器
        var childVcs = [UIViewController]()
        let category = CategoryViewController()
        category.navigationView = navigaitonView
        childVcs.append(category)
        childVcs.append(ChildRecommendViewController())
        for _ in 0..<2{
            let vc  = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: .zero, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    

        //设置UI
       
        setupUI()
        setupConstraints()
    
       
    }
    

   

}

// MARK: - 设置UI界面
extension RecommendViewController {
    
    
       func setupUI () {
       
        //设置导航栏
        setupNavigationBar()
        
        view.addSubview(navigaitonView)
        
        view.addSubview(pageTitleView)

        view.addSubview(pageContentView)

    
        
      
    
    }
    
    
      func setupConstraints() {
        
        navigaitonView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kNavigationH)
        }
        
        pageTitleView.snp.makeConstraints { make in
            make.top.equalTo(navigaitonView.snp.bottom).offset(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(kPageControlH)
        }
        
        pageContentView.snp.makeConstraints { (make) in
            make.top.equalTo(pageTitleView.snp.bottom).offset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-kTabbarH)
        }

    }
    
    private func setupNavigationBar(){
        //logo
        let left = UIBarButtonItem(imageName: "logo", highImageName: "logo", size: CGSize(width: 40, height: 40))
        navigationItem.leftBarButtonItem = left
        
        let right = UIBarButtonItem(imageName: "cm_nav_history")
        navigationItem.rightBarButtonItem = right
        
    }
}


// MARK: - 遵守PageTitleViewDelegate
extension RecommendViewController: PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}

// MARK: - 遵守PageContenViewDelegate
extension RecommendViewController: PageContenViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}




