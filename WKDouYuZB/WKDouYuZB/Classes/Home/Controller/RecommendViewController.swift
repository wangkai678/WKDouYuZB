//
//  RecommendViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
//private let kItemMargin : CGFloat = 10;
//private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2;
//private let kNormalItemH : CGFloat = kItemW * 3 / 4;
//private let kPrettyItemH : CGFloat = kItemW * 4 / 3;

private let kCycleViewH : CGFloat = kScreenW * 3 / 8;
private let kGameViewH : CGFloat = 90;


class RecommendViewController: BaseAnchorViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel();
    
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
    }
}

//MARK: - 设置UI界面内容
extension RecommendViewController {
    override func setupUI(){
        super.setupUI()
        collectionView.addSubview(cycleView);
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0);
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    override func loadData(){
        baseVM = recommendVM
        //请求推荐数据
        recommendVM.requestData { 
            self.collectionView.reloadData();
            
            var groups = self.recommendVM.anchorGroups;
            //移除前两个数据
            groups.removeFirst();
            groups.removeFirst();
            //添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            //将数据传给gameview
            self.gameView.groups = groups;
        }
        //请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cysleModels;
        }
    }
}

//MARK: -
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}



