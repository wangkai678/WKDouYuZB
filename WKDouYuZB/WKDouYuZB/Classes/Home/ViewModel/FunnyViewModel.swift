//
//  FunnyViewModel.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{

}

extension FunnyViewModel{
    func loadFunnyData(finishedCallback : @escaping() -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
