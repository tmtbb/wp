//
//  CSCycleView.swift
//  Swift3InfiniteRotate
//
//  Created by macbook air on 16/12/17.
//  Copyright © 2016年 yundian. All rights reserved.
//

import UIKit
import Kingfisher
private let kCellId = "kCellId"
//代理
protocol CSCycleViewDelegate : class {
    func clickedCycleView(_ cycleView : CSCycleView, selectedIndex index: Int)
}
class CSCycleView: UIView {
    //MARK: -- 自定义属性
    fileprivate var titles: [String]?
    fileprivate var images: [String]?
    fileprivate var cycleTimer : Timer?
    
    weak var delegate : CSCycleViewDelegate?
    
    //MARK: -- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        //创建collectionView
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CSCycleCell.self, forCellWithReuseIdentifier: kCellId)
        return collectionView
        }()
    lazy var pageControl : UIPageControl = {[weak self] in
        
        let pageControl = UIPageControl(frame: CGRect(x: self!.bounds.width / 2, y: self!.bounds.height - 20, width: self!.bounds.width / 2, height: 20))
        
        pageControl.pageIndicatorTintColor = .orange
        
        pageControl.currentPageIndicatorTintColor = .green
        //让pageCotrol靠右显示
        pageControl.numberOfPages = self!.images?.count ?? 0
        let pointSize = pageControl.size(forNumberOfPages: self!.images?.count ?? 0)
        //靠右显示
//        pageControl.bounds = CGRect(x: -(pageControl.bounds.width - pointSize.width) / 2 + 10, y: pageControl.bounds.height - 20, width: pageControl.bounds.width / 2, height: 20)
        //中间显示
            pageControl.bounds = CGRect(x: pageControl.bounds.width / 2 , y: pageControl.bounds.height - 20, width: pageControl.bounds.width / 2, height: 20)
        
        return pageControl
        }()
    
    override func layoutSubviews() {
        //设置layout(获取的尺寸准确，所以在这里设置)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        //设置该空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
    }

    //MARK: -- 构造函数
    init(frame: CGRect, images: [String], titles : [String] = []) {
        
        self.images = images
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        removeCycleTimer()
        print("CSCycleView销毁了")
    }
}

//MARK: -- 设置UI界面
extension CSCycleView {
    
    fileprivate func setupUI() {
        
        addSubview(collectionView)
        addSubview(pageControl)
        //添加定时器。先移除再添加
        collectionView.reloadData()
        removeCycleTimer()
        addCycleTimer()
        
        //滚动到该位置（让用户最开始就可以向左滚动）
        collectionView.setContentOffset(CGPoint(x: collectionView.bounds.width * CGFloat((images?.count)!) * 10, y: 0), animated: true)
        
        //点击事件
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector (tapGes(tap:)))
        self.addGestureRecognizer(tap)
    }
}

//MARK: -- UICollectionViewDataSource
extension CSCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! CSCycleCell
        if (titles?.count)! > 0 {
            
            cell.titleLabel.text = titles?[indexPath.row % titles!.count]
        }
        
        var header : String?
        if images![indexPath.row % images!.count].characters.count >= 4 {
            header = (images![indexPath.row % images!.count] as NSString).substring(to: 4)
        }
        if header == "http" {
            //            let url = NSURL(string: images![indexPath.row % images!.count])
            //            let data = NSData(contentsOf: url! as URL)
            //            cell.iconImageView.image = UIImage(data: data as! Data)
            let url = URL(string: images![indexPath.row % images!.count])
            cell.iconImageView.kf.setImage(with: url)
        }else {
            cell.iconImageView.image = UIImage(named: images![indexPath.row % images!.count])
        }
        return cell
    }
    
}


//MARK: -- UICollectionViewDelegate
extension CSCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (images?.count ?? 0)
    }
    
    //当用户拖拽时，移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    //停止拖拽，加入定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK: -- 时间控制器
extension CSCycleView {
    
    fileprivate func addCycleTimer() {
        //        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        weak var weakSelf = self//解决循环引用
        if #available(iOS 10.0, *) {
            cycleTimer = Timer(timeInterval: 3.0, repeats: true, block: {(timer) in
                weakSelf!.scrollToNextPage()
            })
        } else {
            // Fallback on earlier versions
        }
       cycleTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        
    }
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()//移除
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNextPage() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

//MARK: -- YLCycleViewDelegate
extension CSCycleView {
    
    @objc fileprivate func tapGes(tap: UITapGestureRecognizer) {
        guard (tap.view as? CSCycleView) != nil else { return }
        if (delegate != nil) {
            delegate?.clickedCycleView(self, selectedIndex: pageControl.currentPage)
        }
        print("点击了第: \(pageControl.currentPage)页")
    }
}


