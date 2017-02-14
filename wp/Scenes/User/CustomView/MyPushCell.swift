//
//  MyPushCell.swift
//  wp
//
//  Created by macbook air on 17/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class MyPushCell: UITableViewCell {

    @IBOutlet weak var garyBtn: UIButton!
    
    @IBOutlet weak var redBtn: UIButton!
 
    @IBOutlet weak var redBtnWidth: NSLayoutConstraint!
    //百分比
    @IBOutlet weak var percentLabel: UILabel!
    //胜率
    @IBOutlet weak var winRate: UILabel!
    //胜场
    @IBOutlet weak var winNumber: UILabel!
    let percentNumber:CGFloat = 0.45
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redBtn.layer.cornerRadius = 10
        garyBtn.layer.cornerRadius = 10
        let nuber = garyBtn.frame.size.width * (UIScreen.main.bounds.width / 375)
        redBtnWidth.constant = nuber * percentNumber
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
