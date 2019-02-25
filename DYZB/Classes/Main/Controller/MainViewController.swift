//
//  MainViewController.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/23.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Recommend")
        addChildVC(storyName: "Entertainment")
        addChildVC(storyName: "Attention")
        addChildVC(storyName: "Fish")
        addChildVC(storyName: "Discover")
        
    }
    

    private func addChildVC(storyName: String) {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVC)
        
    }

}
