//
//  PageTitleView.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/9.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit


private let kScrollLineH : CGFloat = 2;

class PageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate var titles:[String];
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]();
    
     //MARK:- 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        scrollView.isPagingEnabled = false;
        scrollView.bounces = false;
        return scrollView;
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView();
        scrollLine.backgroundColor = UIColor.orange;
        return scrollLine;
    }()
    
    //MARK:- 自定义构造函数
    init(frame:CGRect, titles : [String]) {
        self.titles = titles;
        super.init(frame: frame);
        //设置UI界面
        setupUI();
    }
    
    //如果重写init必须重写下面的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

//MARK:- 设置UI界面
extension PageTitleView{
    fileprivate func setupUI(){
        addSubview(scrollView);
        scrollView.frame = bounds;
        
        //添加title对应的label
        setupTitleLabels();
        
        //设置底线和滚动的滑块
        setupBottomMenuAndScrollLine();
    }
    
    private func setupTitleLabels(){
        let labelW:CGFloat = frame.width / CGFloat(titles.count);
        let labelH:CGFloat = frame.height - kScrollLineH;
        let labelY:CGFloat = 0;
        for(index,title) in titles.enumerated(){
            let label = UILabel();
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 16.0);
            label.textAlignment = .center;
            
            let labelX:CGFloat = labelW * CGFloat(index);
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            scrollView.addSubview(label);
            titleLabels.append(label);
        }
    }
    private func setupBottomMenuAndScrollLine(){
        //添加底线
        let bottomLine = UIView();
        bottomLine.backgroundColor = UIColor.lightGray;
        let lineH : CGFloat = 0.5;
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH);
        addSubview(bottomLine);
        
        guard let firstLabel = titleLabels.first else {
            return;
        }
        firstLabel.textColor = UIColor.orange;
        //添加scrollLine
        scrollView.addSubview(scrollLine);
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH);
    }
    
}
