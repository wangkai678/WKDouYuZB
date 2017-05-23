//
//  CollectionCycleCell.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/23.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell{
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    

    var cycleModel : CycleModel?{
        didSet{
            guard let cycleModel = cycleModel else {return}
            titleLabel.text = cycleModel.title;
            guard let iconURL = URL(string: cycleModel.pic_url) else {return}
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL), placeholder: UIImage(named:"Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
