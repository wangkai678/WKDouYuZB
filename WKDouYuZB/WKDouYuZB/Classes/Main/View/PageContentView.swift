//
//  PageContentView.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/9.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kContentCellID = "contentCellID";

class PageContentView: UIView {
    
     //MARK:-自定义属性
    fileprivate var childVcs : [UIViewController];
    fileprivate var parentViewController : UIViewController;

    //MARK:-懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout);
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false;
        collectionView.dataSource = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView;
    }();
    
    //MARK:-自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
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
            parentViewController.addChildViewController(childVc);
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
