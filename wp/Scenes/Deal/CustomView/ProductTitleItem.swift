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
    @IBOutlet weak var iconImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(object: AnyObject, hiddle: Bool) {
        if let product: ProductModel = object as? ProductModel{
            titleLabel.text = product.showSymbol
            titleLabel.textColor = hiddle ?  UIColor.init(rgbHex: 0x999999) : AppConst.Color.CMain
            iconImage.isHidden = hiddle
        }
    }
}

class KLineTitleItem: TitleItem {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(object: AnyObject, hiddle: Bool) {
        if let title: String = object as? String{
            titleLabel.text = title
            titleLabel.textColor = hiddle ?  UIColor.init(rgbHex: 0x999999) : UIColor.init(rgbHex: 0xe48723)
            redImage.isHidden = hiddle
            redImage.backgroundColor = UIColor.init(rgbHex: 0xe48723)
        }
    }
}

