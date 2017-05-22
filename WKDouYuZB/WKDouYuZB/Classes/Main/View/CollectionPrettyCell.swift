//
//  CollectionPrettyCell.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/10.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    
    //MARK: - 控件属性属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK: - 定义模型属性
    var anchor : AnchorModel?{
        didSet{
            //校验模型是否有值
            guard let anchor = anchor else {return}
            
            //显示在线人数
            var onlineStr : String = "";
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线";
            }else{
                onlineStr = "\(anchor.online)在线";
            }
            onlineBtn.setTitle(onlineStr, for: .normal);
            //昵称
            nickNameLabel.text = anchor.nickname;
            //显示所在城市
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            //设置封面图片
            guard let iconUrl = NSURL(string: anchor.vertical_src) else {return}
//            iconImageView.kf_setImage(with: <#T##Resource?#>)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
