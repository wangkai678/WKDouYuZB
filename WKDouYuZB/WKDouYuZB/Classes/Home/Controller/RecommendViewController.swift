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
private let kNormalItemH : CGFloat = kItemW * 3 / 4;
private let kPrettyItemH : CGFloat = kItemW * 4 / 3;
private let kHeaderViewH : CGFloat = 50;

private let kNormalCellID : String = "kNormalCellID";
private let kPerttyCellID : String = "kPerttyCellID";
private let kHeaderViewID : String = "kHeaderViewID";

class RecommendViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout();
//        layout.itemSize = CGSize(width:kItemW,height:kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.headerReferenceSize = CGSize(width:kScreenW,height:kHeaderViewH);
        layout.sectionInset = UIEdgeInsets(top:0, left:kItemMargin, bottom:0, right:kItemMargin);
        let collectionView = UICollectionView(frame:self.view.bounds,collectionViewLayout:layout);
        collectionView.backgroundColor = UIColor.white;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.register(UINib(nibName: "CollectionViewNormalCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID);
        collectionView.register(UINib(nibName: "CollectionPrettyCell",bundle:nil), forCellWithReuseIdentifier: kPerttyCellID);
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID);
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        return collectionView;
    }()
    
    //MARK: - 系统回调函数
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        
        NetworkTools.requestData(type: .GET, URLString: "http://static.deruimu.com/sources/cms/1493176163536506086.jpg") { (response) in
            print(response);
        }
    }
}

//MARK: - 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView);
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        var cell : UICollectionViewCell;
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath);
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath);
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath);
        return headerView;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width:kItemW,height:kPrettyItemH);
        }else{
            return CGSize(width:kItemW,height:kNormalItemH);
        }
    }
}
