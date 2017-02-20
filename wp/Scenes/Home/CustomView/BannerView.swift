//
//  BannerView.swift
//  wp
//
//  Created by mu on 2017/2/14.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import iCarousel
import Kingfisher
class BannerItemView: UIView {
    let itemImage: UIImageView = UIImageView.init(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(itemImage)
        itemImage.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc protocol BannerViewDelegate{
    func banner(_ banner: iCarousel, didSelectItemAt index: Int)
}

class BannerView: iCarousel, iCarouselDelegate, iCarouselDataSource {
    
    weak var bannerDelegate: BannerViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
        delegate = self
        dataSource = self
        bannerData = []
        type = .linear
        scrollSpeed = 0.3
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    var bannerData: [AnyObject]!{
        didSet{
            if bannerData.count > 0 {
                reloadData()
            }
        }
    }
    
    func autoScroll() {
        let index = currentItemIndex == (bannerData.count - 1) ? 0 :currentItemIndex + 1
        scrollToItem(at: index, animated: true)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return bannerData == nil ? 0 : bannerData.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let object: String = bannerData[index] as! String
        let imageResourse = ImageResource.init(downloadURL: URL.init(string: object)!, cacheKey: nil)
        if let reusingView: BannerItemView = view as? BannerItemView{
            reusingView.itemImage.kf.setImage(with: imageResourse)
            return reusingView
        }else{
            let item: BannerItemView = BannerItemView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width(), height: frame.size.height))
            item.itemImage.kf.setImage(with: imageResourse)
            return item
        }
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if bannerDelegate != nil  {
            bannerDelegate?.banner(carousel, didSelectItemAt: index)
        }
    }
}



