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
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name;
            guard let iconURL = URL(string: group?.icon_url ?? "") else {
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
