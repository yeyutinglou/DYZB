//
//  UIImage-Extension.swift
//  DYZB
//
//  Created by jyd on 2019/3/1.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil}
        self.init(cgImage: cgImage)
        
    }
}
