//
//  GameViewController.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/28.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let KitemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = KitemW * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel();
    //MARK:懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KitemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: Bundle.main), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth];
        collectionView.backgroundColor = UIColor.white
        return collectionView;
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

//Mark:- 设置UI
extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}

//Mark:- 请求数据
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData { 
            self.collectionView.reloadData()
        }
    }
}

//Mark:- 遵守UICollectionViewDelegate的数据源&代理
extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        let gameModel = gameVM.games[indexPath.item]
        cell.baseGame = gameModel;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
