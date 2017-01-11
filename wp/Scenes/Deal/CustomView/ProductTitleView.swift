//
//  ProductTitleView.swift
//  wp
//
//  Created by 木柳 on 2017/1/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class ProductTitleItem: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ProductTitleView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var products: [ProductModel]? {
        didSet{
            if let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                let count = products != nil ? ((products?.count)! > 3 ? 3 : products?.count ): 3
                flowLayout.itemSize = CGSize.init(width: UIScreen.width()/CGFloat(count!), height: frame.size.height > 0 ? frame.size.height : 60)
            }
            reloadData()
        }
    }
    
    var selectIndex = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        
        if let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let count = products != nil ? ((products?.count)! > 3 ? 3 : products?.count ): 3
            flowLayout.itemSize = CGSize.init(width: UIScreen.width()/CGFloat(count!), height: frame.size.height > 0 ? frame.size.height : 60)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count == nil ? 0 : (products?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductTitleItem = collectionView.dequeueReusableCell(withReuseIdentifier: ProductTitleItem.className(), for: indexPath) as! ProductTitleItem
        let product = products?[indexPath.row]
        cell.titleLabel.text = product?.name
        cell.redView.isHidden = indexPath.row != selectIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        collectionView.reloadData()
    }
}
