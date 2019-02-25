//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/24.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: b / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
