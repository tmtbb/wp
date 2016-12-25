//
//  CSCycleCell.swift
//  Swift3InfiniteRotate
//
//  Created by macbook air on 16/12/17.
//  Copyright © 2016年 yundian. All rights reserved.
//

import UIKit

class CSCycleCell: UICollectionViewCell {
    //声明属性
    //    var dataSource : [[String]]!
    lazy var iconImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        iconImageView.frame = self.bounds
        bottomView.frame = CGRect(x: 0, y: iconImageView.bounds.height - 30, width: iconImageView.bounds.width, height: 30)
        titleLabel.frame = CGRect(x: 10, y: iconImageView.bounds.height - 25, width: iconImageView.bounds.width / 2, height: 20)
        
        //设置属性
        bottomView.backgroundColor = .clear
        bottomView.alpha = 0.3
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(bottomView)
        contentView.addSubview(titleLabel)
        
    }

}
