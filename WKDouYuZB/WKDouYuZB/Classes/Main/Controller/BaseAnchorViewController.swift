//
//  BaseAnchorViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10;
private let kHeaderViewH : CGFloat = 50;

private let kNormalCellID : String = "kNormalCellID";
private let kHeaderViewID : String = "kHeaderViewID";

let kPerttyCellID : String = "kPerttyCellID";
let kNormalItemW : CGFloat = (kScreenW - 3*kItemMargin)/2;
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4;
let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3;

class BaseAnchorViewController: BaseViewController {

    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width:kNormalItemW,height:kNormalItemH);
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

//MARK: - 设置UI界面
extension BaseAnchorViewController{
     override func setupUI(){
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}

//MARK: - 请求数据
extension BaseAnchorViewController{
     func loadData(){
        
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension BaseAnchorViewController :UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

//MARK: - 遵守UICollectionViewDelegate
extension BaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc(){
        
    }
    
    private func pushNormalRoomVc(){
        
    }
}
