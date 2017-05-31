//
//  AmuseViewModel.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
  
}

extension AmuseViewModel{
    func loadAmuseData(finishedCallback: @escaping() -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
