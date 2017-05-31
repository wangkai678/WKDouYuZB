//
//  BaseViewModel.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class BaseViewModel {
      lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel{
    func loadAnchorData(isGroupData : Bool ,URLString: String,parameters: [String : Any]? = nil,finishedCallback: @escaping() -> ()) {
        NetworkTools.requestData(type: .GET, URLString: URLString,parameters: parameters) { (result) in
            
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            if isGroupData{
                for dict in dataArray{
                    self.anchorGroups.append( AnchorGroup(dict:dict))
                }
            }else{
                let group = AnchorGroup()
                for dict in dataArray{
                    group.anchors.append( AnchorModel(dict:dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}
