//
//  CollectionGameCell.swift
//  WKDouYuZB
//
//  Created by wangkai on 2017/5/23.
//  Copyright © 2017年 wk. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var baseGame : BaseGameModel?{
        didSet{
            titleLabel.text = baseGame?.tag_name;
            guard let iconURL = URL(string: baseGame?.icon_url ?? "") else {
                iconImageView.image = UIImage(named: "home_more_btn")
                return;
            }
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
