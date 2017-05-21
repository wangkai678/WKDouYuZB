//
//  RecommendViewModel.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/21.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class RecommendViewModel {
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]();
}

// MARK:-发送网络请求
extension RecommendViewModel{
    func requestData(){
        //1.请求推荐数据
        
        //2.请求第二部分颜值数据
        
        //3.请求后面部分的游戏数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String:NSObject] else { return };
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return};
            for dict in dataArray{
                let group = AnchorGroup(dict: dict);
                self.anchorGroups.append(group);
            }
            
            for group in self.anchorGroups{
                for anchor in group.anchors{
                    print(anchor.nickname);
                }
            }
        }
    }
}
