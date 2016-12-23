//
//  CSMenuViewSubCell.swift
//  Swift3InfiniteRotate
//
//  Created by macbook air on 16/12/17.
//  Copyright © 2016年 yundian. All rights reserved.
//

import UIKit

class CSMenuViewSubCell: UICollectionViewCell {
    @IBOutlet weak var imageViewH: NSLayoutConstraint!
    @IBOutlet weak var imageViewW: NSLayoutConstraint!
    
    //空间属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageViewSize : CGSize = CGSize(width: 48, height: 48) {
        
        didSet {
            self.imageViewW.constant = imageViewSize.width
            self.imageViewH.constant = imageViewSize.height
            if imageViewSize.width == imageViewSize.height {
                
                iconImageView.layer.cornerRadius = imageViewSize.width / 2
                iconImageView.layer.masksToBounds = true
                
            }else {
                //不是正方形。什么都不做
                iconImageView.layer.cornerRadius = 0
                iconImageView.layer.masksToBounds = false
            }
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = imageViewSize.width / 2
        iconImageView.layer.masksToBounds = true
    }

}
