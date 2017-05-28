//
//  GameViewModel.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/28.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class GameViewModel{
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () ->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            //获取数据
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else{return}
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
