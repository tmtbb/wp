//
//  NoticeICarousel.swift
//  wp
//
//  Created by mu on 2017/2/14.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import iCarousel
import DKNightVersion

class NoticeItem: UIView {
    let iconImage: UIImageView = UIImageView.init(image: UIImage.init(named: ""))
    lazy var followBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("跟单", for: .normal)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(rgbHex: 0x666666)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(12)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
        
        addSubview(followBtn)
        followBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-12)
            make.size.equalTo(CGSize.init(width: 70, height: 33))
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(iconImage.snp.right).offset(12)
            make.right.equalTo(followBtn.snp.left).offset(-12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class NoticeICarousel: iCarousel, iCarouselDelegate, iCarouselDataSource {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        type = .rotary
        isVertical = true
        noticeData = []
    }
    
    var noticeData: [AnyObject]!{
        didSet{
            if noticeData.count > 0 {
                reloadData()
            }
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return noticeData == nil ? 0 : noticeData.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        if let reusingView: NoticeItem = view as? NoticeItem{
            return reusingView
        }else{
            let item: NoticeItem = NoticeItem.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width(), height: frame.size.height))
            return item
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
    }

}
