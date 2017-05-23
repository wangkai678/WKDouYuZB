//
//  RecommendViewModel.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/21.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]();
    lazy var cysleModels : [CycleModel] = [CycleModel]();
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup();
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup();

}

// MARK:-发送网络请求
extension RecommendViewModel{
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()){
        //0.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()];
        
        //创建group
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        //1.请求推荐数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String:NSObject] else { return };
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return};
            self.bigDataGroup.tag_name = "热门";
            self.bigDataGroup.icon_name = "home_header_hot";
            for dict in dataArray{
                let anchor = AnchorModel(dict : dict);
                self.bigDataGroup.anchors.append(anchor);
            }
            dispatchGroup.leave();
        }
        
        //2.请求第二部分颜值数据
        dispatchGroup.enter();
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String:NSObject] else { return };
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return};
            self.prettyGroup.tag_name = "颜值";
            self.prettyGroup.icon_name = "home_header_phone";
            
            for dict in dataArray{
                let anchor = AnchorModel(dict : dict);
                self.prettyGroup.anchors.append(anchor);
            }
             dispatchGroup.leave();
        };
        
        //3.请求后面部分的游戏数据
        dispatchGroup.enter();
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            guard let resultDict = result as? [String:NSObject] else { return };
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return};
            for dict in dataArray{
                let group = AnchorGroup(dict: dict);
                self.anchorGroups.append(group);
            }
            dispatchGroup.leave();
        }
        //所有数据都请求到了
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0);
            self.anchorGroups.insert(self.bigDataGroup, at: 0);
            finishCallback();
        }
    }
    //请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return};
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else{return}
            for dict in dataArray{
                
                self.cysleModels.append(CycleModel(dict: dict));
            }
            finishCallback();
        }
    }
}

