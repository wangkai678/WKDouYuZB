//
//  RecommendGameView.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/23.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10.0

class RecommendGameView: UIView {
    
    var groups : [AnchorGroup]?{
        didSet{
            //移除前两个数据
            groups?.removeFirst();
            groups?.removeFirst();
            //添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        //设置改控件不随着父控件的拉伸而拉伸
        self.autoresizingMask = []
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: Bundle.main), forCellWithReuseIdentifier: kGameCellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin);
    }
}

extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView;
    }
}

//MARK:- UICollectionViewDataSource
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell;
        
    }
}
