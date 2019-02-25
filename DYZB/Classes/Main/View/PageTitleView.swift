//
//  PageTitleView.swift
//  DYZB
//
//  Created by 杜玉伟 on 2019/2/23.
//  Copyright © 2019年 jyd. All rights reserved.
//

import UIKit
// MARK: - 定义协议
protocol PageTitleViewDelegate: class  {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

// MARK: - 定义常量
private let kNormalFont: CGFloat = 16
private let kSelectFont: CGFloat = 20
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (56, 31, 9)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (249, 249, 249)

// MARK: - 定义PageTitleView类
class PageTitleView: UIView {
    
    // MARK: - 定义属性
    private var titles: [String]
    var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 懒加载
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    

    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI
extension PageTitleView {
    
    private func setupUI() {
        //添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //  添加title对应的Label
        setupTitleLabels()
        
        //设置默认选中
        setupFirstLabel()
    }
    
    private func setupTitleLabels() {
        
        //确定的位置
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height
        let labelY: CGFloat = 0
        
        //循环创建
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            //属性
            label.text = title
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: kNormalFont)
            label.textAlignment = .center
            label.tag = index
            
            //动态位置
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            scrollView .addSubview(label)
            titleLabels .append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    
    private func setupFirstLabel() {
        
        guard let firstLabel = titleLabels.first else {return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        firstLabel.font = UIFont.systemFont(ofSize: kSelectFont)
        
    }
}

// MARK: - 监听label点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        
        //获取新旧label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        let oldLabel = titleLabels[currentIndex]
        
        //设置属性
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        oldLabel.font = UIFont.systemFont(ofSize: kNormalFont)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentLabel.font = UIFont.systemFont(ofSize: kSelectFont)
        
        //保持下标值
        currentIndex = currentLabel.tag
        
       //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


// MARK: - 对外暴露方法
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //获取label
       
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //颜色和字体的变化范围
        let fontRange = kSelectFont - kNormalFont
        let colorRange = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //变化的label
        sourceLabel.font = UIFont.systemFont(ofSize: kSelectFont - fontRange * progress)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorRange.0 * progress, g: kSelectColor.1 - colorRange.1 * progress, b: kSelectColor.2 - colorRange.2 * progress)
        targetLabel.font = UIFont.systemFont(ofSize: kNormalFont + fontRange * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRange.0 * progress, g: kNormalColor.1 + colorRange.1 * progress, b: kNormalColor.2 + colorRange.2 * progress)
         currentIndex = targetIndex
    }
}
