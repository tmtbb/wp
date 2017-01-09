//
//  HomeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class HomeVC: BaseTableViewController {
    
    @IBOutlet weak var highestPrice: UILabel!
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var priceToday: UILabel!
    @IBOutlet weak var yesterdayEnd: UILabel!
    @IBOutlet weak var nowPrice: UILabel!
    @IBOutlet weak var gradient: UILabel!
    @IBOutlet weak var variation: UILabel!
    
    //MARK: --LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotify()
        initData()
        initUI()
        self.title = ""
        let images: [String] = ["1", "1", "1"]
        let contentSourceArray: [String] = ["这是一条重大新闻","吃货节到了钱包准备好了吗","独家福利来就送!"]
        let tagSourceArray: [String] = ["跟单", "跟单", "跟单"]
        tableView.tableHeaderView = setupHeaderView(cycleImage: images, contentSourceArray: contentSourceArray, tagSourceArray:tagSourceArray)
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: --HeaderView
    func setupHeaderView (cycleImage:[String],contentSourceArray:[String], tagSourceArray:[String]) -> (UIView) {
        let sunView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 170))
        //创建无限轮播
        let cycleView = CSCycleView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 135), images: cycleImage, titles: [])
        cycleView.delegate = self;
        sunView.addSubview(cycleView)
        //喇叭图片
        let hornImage = UIImageView(image: UIImage(named: "horn"))
        sunView.addSubview(hornImage)
        hornImage.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(9)
            make.left.equalTo(sunView).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(17)
        }
        //特别通知
        let informLabel = UILabel()
        informLabel.text = "特别通知"
        informLabel.font = UIFont.systemFont(ofSize: 12)
        informLabel.textColor = UIColor(rgbHex: 0x666666)
        sunView.addSubview(informLabel)

        informLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(11)
            make.left.equalTo(hornImage.snp.right).offset(10)
        }
        //跟单轮播
        let singlerView = CSSinglerowView(frame: CGRect(x: 0, y: 0, width: 220, height: 30), scrollStyle: .up, roundTime: 2, contentSource: contentSourceArray, tagSource: tagSourceArray)
        singlerView.backColor = UIColor.clear
        singlerView.contentTextColor = UIColor.black
        singlerView.tagTextColor = UIColor.blue
        singlerView.delegate = self
        sunView .addSubview(singlerView)
        singlerView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(2)
            make.left.equalTo(informLabel.snp.right).offset(27)
            make.bottom.equalTo(sunView).offset(0)
            make.width.equalTo(220)
        }
        return sunView
    }
    //MARK: --DATA
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
//        if offsetY >= 100 {
//            translucent(clear: false)
//        }
//        if offsetY < 100 {
//            translucent(clear: true)
//        }
    }
    
    //MARK: --DATA
    func initData() {
    }
    //MARK: --UI
    func initUI() {
        navigationController?.addSideMenuButton()
        self.title = "首页"
        
    }
    //MARK: --UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        if section == 1 {
            
            return 5
        }
        return 6
    }
    //MARK: --NotificationCenter
    func registerNotify() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(jumpToMyMessageController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyMessage), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToMyAttentionController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyAttention), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToMyPushController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyPush), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToMyBaskController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyBask), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToDealController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToDeal), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToFeedbackController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToFeedback), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToProductGradeController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToProductGrade), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToAttentionUsController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToAttentionUs), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToMyWealtVC), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyWealtVC), object: nil)
    }
    //MARK: --NotificationCenter-realize
    func jumpToMyMessageController() {
        
        performSegue(withIdentifier: MyMessageController.className(), sender: nil)
    }
    func jumpToMyAttentionController() {
        
        performSegue(withIdentifier: MyAttentionController.className(), sender: nil)
    }
    func jumpToMyPushController() {
        
        performSegue(withIdentifier: MyPushController.className(), sender: nil)
    }
    func jumpToMyBaskController() {
        
        performSegue(withIdentifier: MyBaskController.className(), sender: nil)
    }
    func jumpToDealController() {
        
        performSegue(withIdentifier: DealController.className(), sender: nil)
    }
    func jumpToFeedbackController() {
        
        let feedbackVC = FeedbackController()
        navigationController?.pushViewController(feedbackVC, animated: true)
    }
    func jumpToProductGradeController() {
        
        let productGradeVC = ProductGradeController()
        navigationController?.pushViewController(productGradeVC, animated: true)
    }
    func jumpToAttentionUsController() {
        
        let attentionUsVC = AttentionUsController()
        navigationController?.pushViewController(attentionUsVC, animated: true)
    }
    func jumpToMyWealtVC() {
        
    }
    
    //MARK: -- 跳转到交易tabBar上
    @IBAction func dealDidButton(_ sender: AnyObject) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func immediatelyMaster(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    @IBAction func historyMaster(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
}
//MARK: -- CSCycleViewDelegate,CSSinglerViewDelegate
extension HomeVC:CSCycleViewDelegate,CSSinglerViewDelegate {
    
    func  clickedCycleView(_ cycleView : CSCycleView, selectedIndex index: Int) {
        
        print("点击了第\(index)页")
    }
    func singlerView(_ singlerowView: CSSinglerowView, selectedIndex index: Int) {
        
        print("点击了第\(index)个数据")
        
    }
}

