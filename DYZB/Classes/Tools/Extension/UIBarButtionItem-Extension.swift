//
//  UIBarButtionItem-Extension.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/23.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //便利构造器
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != "" {
             btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        } else {
             btn.frame = CGRect(origin: .zero, size: size)
        }
       
        self.init(customView: btn)
    }
}
