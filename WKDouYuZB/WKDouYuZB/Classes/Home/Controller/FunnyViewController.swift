//
//  FunnyViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FunnyViewController{
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, 0, 0)
    }
}

extension FunnyViewController{
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}
