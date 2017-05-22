//
//  CollectionHeaderView.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
     //MARK:- 定义模型属性
    var group :  AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")//？是可选类型就是不知道有没有值，？？意思是如果没有值就传一个默认值
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
}
