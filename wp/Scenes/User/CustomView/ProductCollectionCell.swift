//
//  ProductCollectionCell.swift
//  wp
//
//  Created by macbook air on 17/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ProductCollectionCell: TitleItem {
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var productLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func update(object: AnyObject, hiddle: Bool) {
        if let title: String = object as? String {
            productLabel.text = title
            redView.isHidden = hiddle
        }
    }
}
