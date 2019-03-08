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
    
    
    // MARK: - 懒加载
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        return imageView
    }()
    
    lazy var textFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "🔍"
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    lazy var historyBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cm_nav_history"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupUI()
        setupConstraints()
      
    }
    

}



extension BaseViewController {
    @objc func setupUI() {
        view.addSubview(navigationView)
        
        navigationView.addSubview(logoImageView)
        
        navigationView.addSubview(textFiled)
        
        navigationView.addSubview(historyBtn)
        
    }
    
    @objc func setupConstraints() {
        navigationView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kNavigationH)
        }
        
        let margin: CGFloat = 20
        let height: CGFloat = 30
        let width: CGFloat = 40
        
        
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(navigationView.snp.left).offset(margin)
            make.top.equalTo(navigationView.snp.top).offset(kStatusH)
            make.size.equalTo(CGSize(width: width, height: height))
        }
        
        historyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(navigationView.snp.right).offset(-margin)
            make.topMargin.equalTo(logoImageView)
            make.size.equalTo(CGSize(width: height, height: height))
        }
        
        textFiled.snp.makeConstraints { (make) in
             make.topMargin.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(margin)
            make.right.equalTo(historyBtn.snp.left).offset(-margin)
            make.height.equalTo(height)
        }
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


