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
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotify()
        initData()
        initUI()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableHeaderView = setupHeaderView()
        
    }
    
    //MARK: --HeaderView
    func setupHeaderView () -> (UIView) {
        let sunView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 170))
        let images: [String] = ["1", "1", "1"]
        //创建无限轮播
        let cycleView = CSCycleView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 135), images: images, titles: [])
        cycleView.delegate = self;
        sunView.addSubview(cycleView)
        
        let hornImage = UIImageView(image: UIImage(named: "horn"))
        sunView.addSubview(hornImage)
        hornImage.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(9)
            make.left.equalTo(sunView).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(17)
        }
        let informLabel = UILabel()
        informLabel.text = "特别通知"
        informLabel.font = UIFont.systemFont(ofSize: 12)
        informLabel.textColor = UIColor(rgbHex: 0x666666)
        sunView.addSubview(informLabel)

        informLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(11)
            make.left.equalTo(hornImage.snp.right).offset(10)
        }
        let contentSourceArray: [String] = ["这是一条重大新闻","吃货节到了钱包准备好了吗","独家福利来就送!"]
        let singlerView = CSSinglerowView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30), scrollStyle: .up, roundTime: 2, contentSource: contentSourceArray, tagSource: [] )
        singlerView.backColor = UIColor.clear
        singlerView.delegate = self
        sunView .addSubview(singlerView)
        singlerView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(2)
            make.left.equalTo(informLabel.snp.right).offset(27)
            make.bottom.equalTo(sunView).offset(0)
            make.width.equalTo(300)
        }
        return sunView
    }
    
    //MARK: --DATA
    func initData() {
    }
    //MARK: --UI
    func initUI() {
        navigationController?.addSideMenuButton()
        self.title = "首页"
        let homeStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        present(homeStoryboard.instantiateInitialViewController()!, animated: true, completion: nil)
        
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
    }
    //MARK: --NotificationCenter-realize
    func jumpToMyMessageController() {
        
        performSegue(withIdentifier: MyMessageController.className(), sender: nil)
        hideTabBarWithAnimationDuration()
    }
    func jumpToMyAttentionController() {
        
        performSegue(withIdentifier: MyAttentionController.className(), sender: nil)
        hideTabBarWithAnimationDuration()
    }
    func jumpToMyPushController() {
        
        performSegue(withIdentifier: MyPushController.className(), sender: nil)
        hideTabBarWithAnimationDuration()
    }
    func jumpToMyBaskController() {
        
        performSegue(withIdentifier: MyBaskController.className(), sender: nil)
        hideTabBarWithAnimationDuration()
    }
    func jumpToDealController() {
        
        performSegue(withIdentifier: DealController.className(), sender: nil)
        hideTabBarWithAnimationDuration()
    }
    func jumpToFeedbackController() {
        
        let feedbackVC = FeedbackController()
        navigationController?.pushViewController(feedbackVC, animated: true)
        hideTabBarWithAnimationDuration()
    }
    func jumpToProductGradeController() {
        
        let productGradeVC = ProductGradeController()
        navigationController?.pushViewController(productGradeVC, animated: true)
        hideTabBarWithAnimationDuration()
    }
    func jumpToAttentionUsController() {
        
        let attentionUsVC = AttentionUsController()
        navigationController?.pushViewController(attentionUsVC, animated: true)
        hideTabBarWithAnimationDuration()
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
    //MARK: -- 隐藏tabBar导航栏
    func hideTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        
        var tabFrame = tabBar?.frame
        tabFrame?.origin.y = (window?.bounds)!.maxY
        tabBar?.frame = tabFrame!
        content?.frame = (window?.bounds)!
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

