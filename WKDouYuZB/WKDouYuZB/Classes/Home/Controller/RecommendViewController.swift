//
//  RecommendViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10;
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2;
private let kItemH : CGFloat = kItemW * 3 / 4;
private let kHeaderViewH : CGFloat = 50;

private let kNormalCellID : String = "kNormalCellID";
private let kHeaderViewID : String = "kHeaderViewID";

class RecommendViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width:kItemW,height:kItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.headerReferenceSize = CGSize(width:kScreenW,height:kHeaderViewH);
        layout.sectionInset = UIEdgeInsets(top:0, left:kItemMargin, bottom:0, right:kItemMargin);
        let collectionView = UICollectionView(frame:self.view.bounds,collectionViewLayout:layout);
        collectionView.backgroundColor = UIColor.white;
        collectionView.dataSource = self;
        collectionView.register(UINib(nibName: "CollectionViewNormalCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID);
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth];

        return collectionView;
    }()
    
    //MARK: - 系统回调函数
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        

    }
}

//MARK: - 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView);
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8;
        }
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath);
        return headerView;
    }
}
