//
//  AnchorModel.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/21.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id : Int = 0;
    //房间图片对应的URLString
    var vertical_src : String = "";
    //判断是手机直播还是电脑直播
    //0:电脑直播 1:手机直播
    var isVertical : Int = 0;
    //房间名称
    var room_name : String = "";
    //主播昵称
    var  nickname : String = "";
    //观看人数
    var  online : Int = 0;
    init(dict : [String : NSObject]) {
        super.init();
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
