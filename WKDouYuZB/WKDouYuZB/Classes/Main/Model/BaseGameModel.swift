//
//  BaseGameModel.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/28.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    //组显示的标题
    var tag_name : String = ""
    var icon_url : String = ""
    
    //MARK:-构造函数
    override init() {
        super.init()
    }
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
