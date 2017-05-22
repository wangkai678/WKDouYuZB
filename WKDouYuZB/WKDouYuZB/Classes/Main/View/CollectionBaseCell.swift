//
//  CollectionBaseCell.swift
//  WKDouYuZB
//
//  Created by 王凯 on 17/5/22.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
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

            //设置封面图片
            guard let iconURL =  URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL));
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL), placeholder: UIImage(named:"live_cell_default_phone"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
}
