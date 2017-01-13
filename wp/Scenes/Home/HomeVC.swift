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
    
    @IBOutlet weak var productType: ProductTypeView!
   
    
    lazy var flowListArray: [FlowOrdersList] =  [FlowOrdersList]()
    
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
        
        
        
        
        }
    
    //MARK: --DATA
    func initData() {
    }
    //MARK: --UI
    func initUI() {
        navigationController?.addSideMenuButton()
        let images: [String] = ["1", "1", "1"]
        let contentSourceArray: [String] = ["用户001买涨白银价3666","用户001买涨白银价3666","用户001买涨白银价3666"]
        let tagSourceArray: [String] = ["跟单", "跟单", "跟单"]
        tableView.tableHeaderView = setupHeaderView(cycleImage: images, contentSourceArray: contentSourceArray, tagSourceArray:tagSourceArray)
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        
        productType.delegate = self
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: --HeaderView
    func setupHeaderView (cycleImage:[String],contentSourceArray:[String], tagSourceArray:[String]) -> (UIView) {
        let sunView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 238))
        sunView.backgroundColor = UIColor(rgbHex: 0xEEEEEE)
        //创建无限轮播
        let cycleView = CSCycleView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 188), images: cycleImage, titles: [])
        cycleView.delegate = self;
        sunView.addSubview(cycleView)
        //喇叭图片
        let hornImage = UIImageView(image: UIImage(named: "horn"))
        sunView.addSubview(hornImage)
        hornImage.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(19)
            make.left.equalTo(sunView).offset(15)
            make.width.equalTo(52)
            make.height.equalTo(13)
        }
        //红线
        let redView = UIView()
        redView.backgroundColor = UIColor(rgbHex: 0xFE0000)
        sunView.addSubview(redView)
        redView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(17)
            make.left.equalTo(hornImage.snp.right).offset(9)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        //跟单轮播
        let singlerView = CSSinglerowView(frame: CGRect(x: 0, y: 0, width: 260, height: 36), scrollStyle: .up, roundTime: 2, contentSource: contentSourceArray, tagSource: tagSourceArray)
        singlerView.backColor = UIColor.clear
        singlerView.contentTextColor = UIColor(rgbHex: 0x333333)
        singlerView.tagTextColor = UIColor(rgbHex: 0xFFFFFF)
        singlerView.tagFont = UIFont.systemFont(ofSize: 14)
        singlerView.tagBackgroundColor = UIColor(rgbHex: 0x1E66DC)
        singlerView.delegate = self
        sunView .addSubview(singlerView)
        singlerView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(9)
            make.left.equalTo(redView.snp.right).offset(10)
            make.bottom.equalTo(sunView).offset(0)
            make.right.equalTo(sunView).offset(-15)
        }
        return sunView
    }
    
    //MARK: --监听滑动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }

    //MARK: --UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 10
        }
        if section == 2 {
            return 11
        }
        return 0
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
        
        
        self.performSegue(withIdentifier: DealController.className(), sender: nil)
        
        if checkLogin() {
            AppAPIHelper.user().flowList(flowType: "1,2,3", startPos: 0, count: 10, complete: { (result) -> ()? in
                if result != nil {
                    if let dataArray: [FlowOrdersList] = result as! [FlowOrdersList]? {
                        for model in dataArray{
                            print(model)
                            self.flowListArray.append(model)
                        }
                    
                    }else
                    {
                    print("wei nil")
                    }
                }
                return nil
            }, error: errorBlockFunc())
            
        }
        else{
            
        }
        
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
    //通知跳转到资金页面
    func jumpToMyWealtVC() {
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == DealController.className() {
            let controller = segue.destination as! DealController
            controller.orderListArray = flowListArray
        }
    }
    
    //MARK: -- 跳转到交易tabBar上
    @IBAction func dealDidButton(_ sender: AnyObject) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func immediatelyMaster(_ sender: Any) {
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
