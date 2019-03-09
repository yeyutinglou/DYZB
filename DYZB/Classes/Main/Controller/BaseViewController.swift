//
//  BaseViewController.swift
//  DYZB
//
//  Created by jyd on 2019/3/1.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

     // MARK: - 属性
    var startOffSetY:CGFloat = 0
    
    var navigationView: CustomNavigationView?
    
    
   
    
    // MARK: - 懒加载
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.barTintColor = UIColor.orange
//        setupUI()
//        setupConstraints()
    
    }
    

}








// MARK: - UIScrollViewDelegate代理
extension BaseViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.contentOffset.y <= 0  && startOffSetY == 0{
            return
        }
        
        if startOffSetY > scrollView.contentOffset.y {
            navigationView!.snp.updateConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(kNavigationH)
            }
           

        } else {
            navigationView!.snp.updateConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(kStatusH)
            }
        }
      
    }
    
  
    
}



