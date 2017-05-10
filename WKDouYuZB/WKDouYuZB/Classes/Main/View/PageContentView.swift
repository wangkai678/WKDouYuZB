//
//  PageContentView.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/9.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex : Int,targetIndex:Int);
}

private let kContentCellID = "contentCellID";

class PageContentView: UIView {
    
     //MARK:-自定义属性
    fileprivate var childVcs : [UIViewController];
    fileprivate weak var parentViewController : UIViewController?;
    fileprivate var startOffsetX : CGFloat = 0;
    fileprivate var isForbidScrollDelegate : Bool = false;
    weak var delegate : PageContentViewDelegate?;
    //MARK:-懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = (self?.bounds.size)!;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout);
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView;
    }();
    
    //MARK:-自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        super.init(frame: frame);
        
        //设置UI
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:-UI设置界面
extension PageContentView{
     fileprivate func setupUI(){
        //1.将所有的子控制器添加辅控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc);
        }
        
        //添加collectionView，用于在cell中存放控制器的view
        addSubview(collectionView);
        collectionView.frame = bounds;
        
    }
}

//MARK:-遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath);
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview();
        }
        
        //给cell设置内容
        let childVc = childVcs[indexPath.item];
        childVc.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(childVc.view);
        return cell;
    }
}

//MARK:-遵守UICollectionViewDelegate
extension PageContentView :UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX =  scrollView.contentOffset.x;
        isForbidScrollDelegate = false;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是否是点击事件，如果是点击事件不用执行滚动代理
        if isForbidScrollDelegate{
            return;
        }
        
        var progress:CGFloat = 0;
        var sourceIndex :Int = 0;
        var targetIndex :Int = 0;
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x;
        let scrollviewW = scrollView.bounds.size.width;
        
        if currentOffsetX > startOffsetX{//左滑
            //计算progress
            progress = currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW);
            
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollviewW);
            
            //计算targetIndex
            targetIndex = sourceIndex + 1;
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1;
            }
            
            //如果完全滑过去
            if currentOffsetX - startOffsetX == scrollviewW{
                progress = 1;
                targetIndex = sourceIndex;
            }
            
        }else{//右滑
            //计算progress
            progress  = 1 - (currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW));
            
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollviewW);
            
            //计算sourceIndex
            sourceIndex = targetIndex + 1;
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count-1;
            }
        }
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex);
    }
}

//MARK:-对外暴漏的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int) {
        isForbidScrollDelegate = true;
        let offsetX = CGFloat(currentIndex) * collectionView.frame.size.width;
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false);
    }
}
