

//
//  SecondViewCell.swift
//  wp
//
//  Created by macbook air on 17/1/12.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

@objc protocol  SecondViewCellDelegate: NSObjectProtocol{
    
    @objc optional func masterDidClick()
}

class SecondViewCell: UITableViewCell {
    
    weak var delegate: SecondViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //即时高手跳转
    @IBAction func forthwithBtn(_ sender: Any) {
        delegate?.masterDidClick!()
    }
    //历史高手跳转
    @IBAction func historyBtn(_ sender: Any) {
        delegate?.masterDidClick!()
    }

    
    
}
