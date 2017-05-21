//
//  NSDate-Extension.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/21.
//  Copyright © 2017年 wk. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String{
        let nowDate = NSDate();
        let intetval = Int(nowDate.timeIntervalSince1970);
        return "\(intetval)";
    }
}
