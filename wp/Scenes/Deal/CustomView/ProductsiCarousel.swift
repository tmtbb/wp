//
//  ProductsiCarousel.swift
//  wp
//
//  Created by mu on 2017/2/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import iCarousel
import DKNightVersion
class ProductiCarousel: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(rgbHex: 0x666666)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.auxiliary)
        return label
    }()
    
    private lazy var feeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = UIColor.init(rgbHex: 0x666666)
        return label
    }()
    
    var object: ProductModel? {
        didSet{
            if let product: ProductModel = object {
                titleLabel.text = product.showName
                priceLabel.text = String.init(format: "%.2f元/手数", product.price)
                feeLabel.text = "手续费\(product.openChargeFee * 100)%"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.init(rgbHex: 0xcccccc).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 3
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(14)
            make.centerX.equalToSuperview()
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addSubview(feeLabel)
        feeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc protocol ProductsiCarouselDelegate{
    func didSelectProduct(product: ProductModel)
}

class ProductsiCarousel: iCarousel, iCarouselDelegate, iCarouselDataSource{
    var objects: [ProductModel]? {
        didSet{
            reloadData()
        }
    }

    weak var productDelegate: ProductsiCarouselDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        type = .rotary
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return objects?.count == nil ? 0 : (objects?.count)!
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        if let reuserView: ProductiCarousel  = view as? ProductiCarousel{
            return reuserView
        }
        let item =  ProductiCarousel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width()*0.66, height: 88))
        item.object = objects![index]
        return item
    }
    

    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        let index = currentItemIndex
        if objects != nil && index < objects!.count{
            let product = objects![index]
            if productDelegate != nil{
                productDelegate?.didSelectProduct(product: product)
            }
            DealModel.share().buyProduct = product
        }
    }
}
