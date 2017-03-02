//
//  DealListCell.swift
//  TestCountDown
//
//  Created by J-bb on 17/2/9.
//  Copyright © 2017年 J-bb. All rights reserved.
//

import UIKit
import DKNightVersion


class DealListCell: UITableViewCell {

    var startTime = 0
    var timeCount = 0
    var totalCount = 0
    var positionModel:PositionModel?
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "上海-法兰克福1分"
        label.textColor = UIColor.init(rgbHex: 0x333333)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var countLabel:UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(rgbHex: 0x666666)
        label.text = "手数10"
        return label
        
    }()
    
    lazy var countDownLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "00:00:00"
        label.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        return label
    }()
    
    lazy var backView:UIImageView = {
        
        var view = UIImageView()
//        view.layer.cornerRadius = 8
//        view.backgroundColor = UIColor.init(rgbHex: 0xcccccc)
        let image = UIImage(named: "countdown_back")
        view.image = image?.resizableImage(withCapInsets: UIEdgeInsetsMake(5, 13  , 5, 13), resizingMode: UIImageResizingMode.stretch)
        return view
    }()
    
    lazy var progressView:UIImageView = {
        
        var view = UIImageView()
//        view.layer.cornerRadius = 8
//        view.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        let image = UIImage(named: "countDown_progress")
        view.image = image?.resizableImage(withCapInsets: UIEdgeInsetsMake(5, 13  , 5, 23), resizingMode: UIImageResizingMode.stretch)

        return view
    }()
    
    lazy var plainImageView:UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "countdown_plain")
        return imageView
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(countDownLabel)
        contentView.addSubview(backView)
        backView.addSubview(progressView)
        progressView.addSubview(plainImageView)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.height.equalTo(13)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.height.equalTo(12)
        }
        countDownLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.height.equalTo(12)
            make.top.equalTo(titleLabel)
            make.width.equalTo(130)
        }
        backView.snp.makeConstraints { (make) in
            make.right.equalTo(countDownLabel)
            make.width.equalTo(countDownLabel)
            make.height.equalTo(15)
            make.top.equalTo(countDownLabel.snp.bottom).offset(7)
        }

        progressView.snp.makeConstraints { (make) in
            make.left.equalTo(backView)
            make.height.equalTo(backView)
            make.width.equalTo(10)
            make.centerY.equalTo(backView)
        }
        plainImageView.snp.makeConstraints { (make) in
            make.right.equalTo(progressView).inset(5)
            make.top.equalTo(progressView.snp.top).offset(3)
            make.bottom.equalTo(progressView.snp.bottom).offset(-3)
            make.centerY.equalTo(progressView)
        }

    }
    
    func setData(positionModel:PositionModel) {
        self.positionModel = positionModel
        startTime = self.positionModel!.positionTime
        totalCount = self.positionModel!.closeTime - startTime
        titleLabel.text = self.positionModel!.name
        countLabel.text = "手数\(self.positionModel!.amount)"
        refreshText()
    }
    
    func refreshText() {
        timeCount = YD_CountDownHelper.shared.getResidueCount(closeTime: positionModel!.closeTime)
        if timeCount >= 0 {
            timeCount -= 1
            countDownLabel.text = YD_CountDownHelper.shared.getTextWithStartTime(closeTime: positionModel!.closeTime)
            countDownLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
            resetProgressViewConstraints()
        }else {
            countDownLabel.text = "00:00:00s"
            countDownLabel.textColor = UIColor.init(rgbHex: 0x999999)
            progressView.snp.remakeConstraints { (make) in
                make.edges.equalTo(backView)
            }
            YD_CountDownHelper.shared.resetDataSource()
        }
    }
    
    func resetProgressViewConstraints() {
        progressView.snp.remakeConstraints { (make) in
            make.left.equalTo(backView)
            make.height.equalTo(backView)
            make.width.equalTo(curretWidth())
            make.centerY.equalTo(backView)
        }
    }
    
    func curretWidth() -> CGFloat {
        return 10 + (1 -  (CGFloat(timeCount) / CGFloat(totalCount))) * (backView.frame.size.width - 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
