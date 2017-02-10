//
//  TitleCollectionview.swift
//  wp
//
//  Created by 木柳 on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class TitleItem: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(object: AnyObject, hiddle: Bool) {
        
    }
}


@objc protocol TitleCollectionviewDelegate {
    func didSelectedObject(_ collectionView: UICollectionView, object: AnyObject?)
}

class TitleCollectionView: UICollectionView , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var objects: [AnyObject]? {
        didSet{
            if let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                let count = objects != nil ? ((objects?.count)! > 3 ? 3 : objects?.count ): 3
                flowLayout.itemSize = CGSize.init(width: UIScreen.width()/CGFloat(count!), height: frame.size.height)
            }
            reloadData()
        }
    }
    var selectIndexPath: IndexPath = IndexPath.init(row: 0, section: 0)
    var reuseIdentifier: String? {
        didSet{
            if reuseIdentifier == nil {
                return
            }

            reloadData()
        }
    }
    
    
    weak var itemDelegate: TitleCollectionviewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        register(TitleItem.self, forCellWithReuseIdentifier: TitleItem.className())
        if let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let count = objects != nil ? ((objects?.count)! > 3 ? 3 : objects?.count ): 3
            flowLayout.itemSize = CGSize.init(width: UIScreen.width()/CGFloat(count!), height: frame.size.height > 0 ? frame.size.height : 60)
            flowLayout.minimumLineSpacing = 0
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects?.count == nil ? 0 : (objects?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TitleItem = collectionView.dequeueReusableCell(withReuseIdentifier: (reuseIdentifier == nil ? TitleItem.className(): reuseIdentifier)!, for: indexPath) as! TitleItem
        let object = objects?[indexPath.row]
        cell.update(object: object!, hiddle: selectIndexPath != indexPath)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndexPath = indexPath
        if let itemDelegate = itemDelegate {
            let object = objects?[indexPath.row]
            itemDelegate.didSelectedObject(collectionView, object: object)
        }
        collectionView.reloadData()
    }
}
