//
//  RoomNormalViewController.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/31.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //用下面注释掉的方法隐藏导航栏滑动返回手势依然会有
//        navigationController?.navigationBar.isHidden = true
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        //依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
          navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
