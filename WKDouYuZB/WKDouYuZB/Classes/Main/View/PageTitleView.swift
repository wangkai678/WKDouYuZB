//
//  PageTitleView.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/9.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

 //MARK:- 定义协议
protocol PageTitleViewDelegate :class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index :Int);
}

 //MARK:- 定义常量
private let kScrollLineH : CGFloat = 2;
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85);
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0);

class PageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate var currentIndex : Int = 0;
    fileprivate var titles:[String];
    weak var delegate : PageTitleViewDelegate?;
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
            label.textColor = UIColor(r:kNormalColor.0,g:kNormalColor.1,b:kNormalColor.2);
            label.textAlignment = .center;
            let labelX:CGFloat = labelW * CGFloat(index);
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            scrollView.addSubview(label);
            titleLabels.append(label);
            
            //添加手势
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target:self,action:#selector(self.titleLabelClick(tapGes:)));
            label.addGestureRecognizer(tapGes);
            
        }
    }
    private func setupBottomMenuAndScrollLine(){
        //添加底线
        let bottomLine = UIView();
        bottomLine.backgroundColor = UIColor(r: 224, g: 224, b: 224);
        let lineH : CGFloat = 0.5;
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH);
        addSubview(bottomLine);
        
        guard let firstLabel = titleLabels.first else {
            return;
        }
        firstLabel.textColor = UIColor(r:kSelectColor.0,g:kSelectColor.1,b:kSelectColor.2);
        //添加scrollLine
        scrollView.addSubview(scrollLine);
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH);
    }
}

//MARK:- 监听label的点击
extension PageTitleView{
    @objc fileprivate func titleLabelClick(tapGes:UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else {
            return;
        }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex];
        oldLabel.textColor = UIColor(r:kNormalColor.0,g:kNormalColor.1,b:kNormalColor.2);
        currentLabel.textColor = UIColor(r:kSelectColor.0,g:kSelectColor.1,b:kSelectColor.2);
        currentIndex = currentLabel.tag;
        
        //滚动条位置发生改变
        let scrollLineX : CGFloat = CGFloat(currentLabel.tag) * scrollLine.frame.width;
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX;
        }
        
        //通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex); 
    }
}

//MARK:-对外暴漏的方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        //1.取出sourceLabel／targtLabel
        let sourceLabel = titleLabels[sourceIndex];
        let targetLabel = titleLabels[targetIndex];
        print(progress,sourceIndex,targetIndex);
        //处理滑块的逻辑
        let moveToTalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        let moveX = moveToTalX * progress;
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX;
        
        //3.颜色的渐变
        //取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2);
        sourceLabel.textColor = UIColor(r:kSelectColor.0 - colorDelta.0 * progress, g:kSelectColor.1 - colorDelta.1 * progress, b:kSelectColor.2 - colorDelta.2 * progress);
        
        targetLabel.textColor = UIColor(r:kNormalColor.0 + colorDelta.0 * progress, g:kNormalColor.1 + colorDelta.1 * progress, b:kNormalColor.2 + colorDelta.2 * progress);
        
        //记录最新的index
        currentIndex = targetIndex;
        
    }
}
