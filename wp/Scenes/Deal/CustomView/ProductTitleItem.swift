//
//  ProductTitleItem.swift
//  wp
//
//  Created by 木柳 on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ProductTitleItem: TitleItem {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(object: AnyObject, hiddle: Bool) {
        if let product: ProductModel = object as? ProductModel{
            titleLabel.text = product.name
            redView.isHidden = hiddle
        }
    }
}
