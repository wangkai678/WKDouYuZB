//
//  NetworkTools.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/11.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

class NetworkTools: NSObject {
    class func requestData(type:MethodType,URLString:String,parameters:[String:String]? = nil,finishedCallback:@escaping (_ result : AnyObject) -> ()){
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post;
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            guard let result = response.result.value else{
                return;
            }
            finishedCallback(result as AnyObject);
        };
    }
}
