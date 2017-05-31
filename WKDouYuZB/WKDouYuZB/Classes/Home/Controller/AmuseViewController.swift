//
//  AmuseViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit


class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - 请求数据
extension AmuseViewController{
   override func loadData(){
        baseVM = amuseVM;
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
        }
    }
}





