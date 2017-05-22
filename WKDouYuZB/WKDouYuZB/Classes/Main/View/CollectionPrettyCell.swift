//
//  CollectionPrettyCell.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    //MARK: - 控件属性属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK: - 定义模型属性
    override var anchor : AnchorModel?{
        didSet{
             super.anchor = anchor;
            //显示所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
