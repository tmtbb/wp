//
//  MyBaskCell.swift
//  wp
//
//  Created by macbook air on 17/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MyBaskCell: OEZTableViewCell {
    //产品类型
    @IBOutlet weak var productType: UILabel!
    //建仓时间
    @IBOutlet weak var positionTime: UILabel!
    //建仓价格
    @IBOutlet weak var positionPrice: UILabel!
    //平仓时间
    @IBOutlet weak var closeOutTime: UILabel!
    //平仓价格
    @IBOutlet weak var closeOutPrice: UILabel!
    //收益
    @IBOutlet weak var profitAndLoss: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func update(_ data: Any!) {
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
