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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
      
    }
    


}

extension BaseViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.contentOffset.y <= 0  && startOffSetY == 0{
            return
        }
        
//        if startOffSetY > scrollView.contentOffset.y {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//
//        } else {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        }
    }
}


