//
//  DealDetailCell.swift
//  wp
//
//  Created by macbook air on 17/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class DealDetailCell: OEZTableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dealType: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
