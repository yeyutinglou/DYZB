//
//  CustomNavigationView.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/3/8.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

class CustomNavigationView: UIView {
    
    // MARK: - 懒加载
    
    
    lazy var headView: UIView = {
        let view = UIView()
     
        return view
    }()
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}

extension CustomNavigationView {
     func setupUI() {
        self.backgroundColor = UIColor.orange
        self.addSubview(navigationView)
        
//        headView.addSubview(navigationView)
        
        navigationView.addSubview(logoImageView)
        
        navigationView.addSubview(textFiled)
        
        navigationView.addSubview(historyBtn)
        
        
        
    }
    
    @objc func setupConstraints() {
        
//        headView.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalToSuperview()
////            make.height.equalTo(kNavigationH)
//        }
        
        
        let margin: CGFloat = 20
        let barH: CGFloat = kNavigationH - kStatusH
        
        
        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(kStatusH)
            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(barH)
        }
        
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(navigationView.snp.left).offset(margin)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(barH)
        }
        
        historyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(navigationView.snp.right).offset(-margin)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(barH)
        }
        
        textFiled.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(margin)
            make.right.equalTo(historyBtn.snp.left).offset(-margin)
            
        }
        
        
        
        
    }
}

