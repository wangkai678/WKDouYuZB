//
//  AmuseViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
 
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
       let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK: - 设置UI界面
extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}

//MARK: - 请求数据
extension AmuseViewController{
   override func loadData(){
        baseVM = amuseVM;
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
            var tempGrous = self.amuseVM.anchorGroups
            tempGrous.removeFirst()
            self.menuView.groups = tempGrous
        }
    }
}





