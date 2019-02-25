//
//  Common.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/23.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit


let kScreenW: CGFloat = UIScreen.main.bounds.size.width

let kScreenH: CGFloat = UIScreen.main.bounds.size.height

let kIsIphoneX: Bool = ((kScreenH == 812 || kScreenH == 896) ? true : false)

let kStatusH: CGFloat = kIsIphoneX ? 44 : 20

let kNavigationH: CGFloat = kIsIphoneX ? 88 : 64

let kTabbarBottomMargin: CGFloat = kIsIphoneX ? 34 : 0

let kTabbarH: CGFloat = kIsIphoneX ? (34 + 49) : 49








