//
//  ProductsiCarousel.swift
//  wp
//
//  Created by mu on 2017/2/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import iCarousel

class ProductiCarousel: UIView {
    
}

class ProductsiCarousel: iCarousel, iCarouselDelegate, iCarouselDataSource{
    var objects: [ProductModel]? {
        didSet{
           
            reloadData()
        }
    }

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
        let item =  ProductiCarousel.init(frame: CGRectZero)
        return item
    }
    
    
}
