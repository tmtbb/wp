//
//  MyBaskCell.swift
//  wp
//
//  Created by macbook air on 17/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MyBaskCell: UITableViewCell {
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var positionTime: UILabel!
    @IBOutlet weak var positionPrice: UILabel!
    @IBOutlet weak var closeOutTime: UILabel!
    @IBOutlet weak var closeOutPrice: UILabel!
    @IBOutlet weak var profitAndLoss: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
