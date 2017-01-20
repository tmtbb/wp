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
    
    //交易明细数据
    lazy var flowListArray: [FlowOrdersList] =  [FlowOrdersList]()
    //行情数据
    lazy var marketArray: [KChartModel] = []
    
    var dict:[AnyObject]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: true)
        showTabBarWithAnimationDuration()
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        registerNotify()
        initData()
        initUI()
        
    }
    
    //MARK: --DATA
    func initData() {
        //0,添加数据监听
        DealModel.share().addObserver(self, forKeyPath: "allProduct", options: .new, context: nil)
        //2,请求商品报价
        if DealModel.share().allProduct.count > 0 {
            initRealTimeData()
        }
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "allProduct" {
            initRealTimeData()
        }
    }
    
    func initRealTimeData() {
        var goods: [AnyObject] = []
        for  product in DealModel.share().allProduct {
            
            let good = [SocketConst.Key.goodType: product.typeCode,
                        SocketConst.Key.exchangeName: product.exchangeName,
                        SocketConst.Key.platformName: product.platformName]
            goods.append(good as AnyObject)
            
        }
        let param: [String: Any] = [SocketConst.Key.id: UserModel.currentUserId,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.goodsinfos: goods]
        AppAPIHelper.deal().realtime(param: param, complete: { [weak self](result) -> ()? in
            if let models: [KChartModel] = result as! [KChartModel]?{
                for model in models{
                    for  product in DealModel.share().allProduct{
                        if model.goodType == product.goodType{
                            model.name = product.name
                        }
                    }
                }
                self?.marketArray = models
                //3,刷新商品报价
                self?.tableView.reloadData()
            }
            return nil
            }, error: errorBlockFunc())
    }
    //MARK: --UI
    func initUI() {
        navigationController?.addSideMenuButton()

        let images: [String] = ["banner", "banner", "banner"]
        let contentSourceArray: [String] = ["用户001111 买涨白银价 3666","用户001买涨白银价3666","用户001买涨白银价3666"]
        let tagSourceArray: [String] = ["跟单", "跟单", "跟单"]
        tableView.tableHeaderView = setupHeaderView(cycleImage: images, contentSourceArray: contentSourceArray, tagSourceArray:tagSourceArray)
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
    }
    
    
    //MARK: --头视图
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
        let screenWidth = UIScreen.main.bounds.size.width
        let screenW = screenWidth / 375
        var width = screenWidth - 101
        if screenW < 1 {
            width = width + 15
        }
        let singlerView = CSSinglerowView(frame: CGRect(x: 0, y: 0, width: width, height: 50), scrollStyle: .up, roundTime: 2, contentSource: contentSourceArray, tagSource: tagSourceArray)
        singlerView.backColor = UIColor.clear
        singlerView.contentTextColor = UIColor(rgbHex: 0x333333)
        if screenWidth < 1 {
            singlerView.contentFont = UIFont.systemFont(ofSize: 13 * screenW)
        }else
        {
            singlerView.contentFont = UIFont.systemFont(ofSize: 14)
        }
        
        singlerView.tagTextColor = UIColor(rgbHex: 0xFFFFFF)
        singlerView.tagFont = UIFont.systemFont(ofSize: 14)
        singlerView.tagBackgroundColor = UIColor(rgbHex: 0xE9573E)
        singlerView.delegate = self
        sunView .addSubview(singlerView)
        if  screenW < 1 {
            singlerView.snp.makeConstraints { (make) in
                make.top.equalTo(cycleView.snp.bottom).offset(0)
                make.left.equalTo(redView.snp.right).offset(10)
                make.bottom.equalTo(sunView).offset(0)
                make.right.equalTo(sunView).offset(0)
            }
        }
        else{
            singlerView.snp.makeConstraints { (make) in
                make.top.equalTo(cycleView.snp.bottom).offset(0)
                make.left.equalTo(redView.snp.right).offset(10)
                make.bottom.equalTo(sunView).offset(0)
                make.right.equalTo(sunView).offset(-15)
            }
        }
        return sunView
    }
    
    //MARK: --监听滑动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    //MARK: --组头高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            
            return 10
        }
        if section == 2 {
            return 11
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0 {
            return 2 //marketArray.count
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return 1
        }
        return 0
    }
    //MARK: --行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 96
        }
        if indexPath.section == 1 {
            return 155
        }
        if indexPath.section == 2 {
            return 106
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell : ProdectCell = tableView.dequeueReusableCell(withIdentifier: "ProdectCell") as! ProdectCell
        if indexPath.section==0 {
            if indexPath.item < marketArray.count && marketArray[indexPath.item] != nil {
//                cell.kChartModel = marketArray[indexPath.item]
            }
            return cell
        }
        if indexPath.section==1 {
            let cell : SecondViewCell = tableView.dequeueReusableCell(withIdentifier: "SecondViewCell") as! SecondViewCell
            cell.delegate = self
            
            return cell
        }
        if indexPath.section == 2 {
            let cell : ThreeCell = tableView.dequeueReusableCell(withIdentifier: "ThreeCell") as! ThreeCell
            return cell
        }
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tabBarController?.selectedIndex = 1
        }
        
    }
    //MARK: --发送通知
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
    //MARK: --通知方法实现
    func jumpToMyMessageController() {
        
        performSegue(withIdentifier: MyMessageController.className(), sender: nil)
    }
    
    //我的关注
    func jumpToMyAttentionController() {
        
        if checkLogin(){
            performSegue(withIdentifier: MyAttentionController.className(), sender: nil)
        }
    }
    //我的推单
    func jumpToMyPushController() {
        
        
        if checkLogin(){
            performSegue(withIdentifier: MyPushController.className(), sender: nil)
            
        }
    }
    //我的晒单
    func jumpToMyBaskController() {
        if checkLogin(){
            performSegue(withIdentifier: MyBaskController.className(), sender: nil)
        }
    }
    //我的交易明细
    func jumpToDealController() {
        if checkLogin() {
            self.performSegue(withIdentifier: DealController.className(), sender: nil)
        }
        
        //        if checkLogin() {
        //            AppAPIHelper.user().flowList(flowType: "1,2,3", startPos: 0, count: 10, complete: { (result) -> ()? in
        //                if result != nil {
        //                    if let dataArray: [FlowOrdersList] = result as! [FlowOrdersList]? {
        //                        for model in dataArray{
        //                            print(model)
        //                            self.flowListArray.append(model)
        //                        }
        //
        //                    }else
        //                    {
        //                        print("wei nil")
        //                    }
        //                }
        //                return nil
        //            }, error: errorBlockFunc())
        //        }
        //        else{
        //
        //        }
        
    }
    //意见反馈
    func jumpToFeedbackController() {
        
//        let feedbackVC = FeedbackController()
//        navigationController?.pushViewController(feedbackVC, animated: true)
    }
    //产品评分
    func jumpToProductGradeController() {
        
        let productGradeVC = ProductGradeController()
        navigationController?.pushViewController(productGradeVC, animated: true)
    }
    //关于我们
    func jumpToAttentionUsController() {
        
        performSegue(withIdentifier: AttentionUsController.className(), sender: nil)
    }
    //通知跳转到资金页面
    func jumpToMyWealtVC() {
        
        let story : UIStoryboard = UIStoryboard.init(name: "Share", bundle: nil)
        
        let wealth  = story.instantiateViewController(withIdentifier: "MyWealtVC")
        
        navigationController?.pushViewController(wealth, animated: true)
        
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
        DealModel.share().removeObserver(self, forKeyPath: "allProduct")
    }
    
    
}
//MARK: -- CSCycleViewDelegate,CSSinglerViewDelegate
extension HomeVC:CSCycleViewDelegate,CSSinglerViewDelegate,SecondViewCellDelegate {
    
    func  clickedCycleView(_ cycleView : CSCycleView, selectedIndex index: Int) {
        
        print("点击了第\(index)页")
    }
    func singlerView(_ singlerowView: CSSinglerowView, selectedIndex index: Int) {
        
        print("点击了第\(index)个数据")
        
    }
    func masterDidClick() {
        tabBarController?.selectedIndex = 2
    }
}
