//
//  CollectionViewNormalCell.swift
//  WKDouYuZB
//
//  Created by wangkai on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    //MARK: - 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: -定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor;
            //房间名称
            roomNameLabel.text = anchor?.room_name;
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
