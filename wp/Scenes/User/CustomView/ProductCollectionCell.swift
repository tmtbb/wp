//
//  ProductCollectionCell.swift
//  wp
//
//  Created by macbook air on 17/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
class ProductCollectionCell: TitleItem {
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var productLabel: UILabel!
    
    let selectorBtn: UIButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func update(object: AnyObject, hiddle: Bool) {
        if let model = object as? ProductModel {
            productLabel.text = model.showSymbol
            
            redView.isHidden = hiddle
            selectorBtn.isSelected = hiddle ? false : true
            if selectorBtn.isSelected {
                productLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
            }
            else{
                productLabel.textColor = UIColor(rgbHex: 0x333333)
            }
            
        }
    }
}
