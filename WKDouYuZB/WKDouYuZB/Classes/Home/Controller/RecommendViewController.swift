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

private let kCycleViewH : CGFloat = kScreenW * 3 / 8;
private let kGameViewH : CGFloat = 90;

private let kNormalCellID : String = "kNormalCellID";
private let kPerttyCellID : String = "kPerttyCellID";
private let kHeaderViewID : String = "kHeaderViewID";

class RecommendViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel();
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
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0);
        return collectionView;
    }()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView();
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH);
        return cycleView;
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView();
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH);
        return gameView;
    }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        
        //发送网络请求
        loadData();
    }
}

//MARK: - 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView);
        collectionView.addSubview(cycleView);
        collectionView.addSubview(gameView)
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    fileprivate func loadData(){
        //请求推荐数据
        recommendVM.requestData { 
            self.collectionView.reloadData();
            //将数据传给gameview
            self.gameView.groups = self.recommendVM.anchorGroups;
        }
        //请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cysleModels;
        }
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section];
        return group.anchors.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let group = recommendVM.anchorGroups[indexPath.section];
        let anchor = group.anchors[indexPath.item];
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath) as! CollectionPrettyCell;
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell;
        }
        cell.anchor = anchor
        return cell;

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView;
        headerView.group = recommendVM.anchorGroups[indexPath.section];
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
