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
import DKNightVersion
import iCarousel
class HomeVC: BaseTableViewController {
    
    //交易明细数据
    lazy var flowListArray: [FlowOrdersList] =  [FlowOrdersList]()
    //行情数据
    lazy var marketArray: [KChartModel] = []
    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var noticeView: NoticeICarousel!
    private var priceTimer: Timer?
    var dict:[AnyObject]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: false)
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
        AppDataHelper.instance().initProductData()
        let bannerStr = "http://upload-images.jianshu.io/upload_images/3959281-9e14f1eaccc36f37.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
        bannerView.bannerData = [bannerStr as AnyObject,bannerStr as AnyObject,bannerStr as AnyObject,bannerStr as AnyObject,bannerStr as AnyObject,bannerStr as AnyObject]
//        noticeView.noticeData = ["这是一个测试文案1" as AnyObject, "这是一个测试文案2" as AnyObject,"这是一个测试文案3"as AnyObject, "这是一个测试文案4" as AnyObject,"这是一个测试文案5"as AnyObject]
        noticeView.isHidden = true
        

        //每隔3秒请求商品报价
        priceTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(initRealTimeData), userInfo: nil, repeats: true)
        DealModel.share().addObserver(self, forKeyPath: AppConst.KVOKey.allProduct.rawValue, options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == AppConst.KVOKey.allProduct.rawValue {
            initRealTimeData()
        }
    }
    
    func initRealTimeData() {
        if DealModel.share().productKinds.count == 0 {
            return
        }
        var goods: [AnyObject] = []
        for  product in DealModel.share().productKinds {
            let good = [SocketConst.Key.aType: SocketConst.aType.currency.rawValue,
                        SocketConst.Key.exchangeName: product.exchangeName,
                        SocketConst.Key.platformName: product.platformName,
                        SocketConst.Key.symbol: product.symbol] as [String : Any]
            goods.append(good as AnyObject)
        }
        let param: [String: Any] = [SocketConst.Key.id: UserModel.currentUserId,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.symbolInfos: goods]
        AppAPIHelper.deal().realtime(param: param, complete: { [weak self](result) -> ()? in
            if let models: [KChartModel] = result as! [KChartModel]?{
                for model in models{
                    for  product in DealModel.share().productKinds{
                        if model.symbol == product.symbol{
                            model.name = product.showSymbol
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
        bannerView.bannerDelegate = self
        title = "航空运费定盘"
        navigationController?.addSideMenuButton()
        tableView.tableHeaderView?.layer.shadowColor = UIColor.black.cgColor
        tableView.tableHeaderView?.layer.shadowOpacity = 0.1
        tableView.tableHeaderView?.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        tableView.backgroundColor = UIColor(rgbHex: 0xffffff)
    }
    
    //MARK: --监听滑动
   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let viewBackColor = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        viewBackColor.backgroundColor = UIColor.white
        return viewBackColor
        
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
            return marketArray.count
        }
//        if section == 1 {
//            return 1
//        }
//        if section == 2 {
//            return 1
//        }
        return 0
    }
    //MARK: --行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
//        if indexPath.section == 1 {
//            return 155
//        }
//        if indexPath.section == 2 {
//            return 106
//        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell : ProdectCell = tableView.dequeueReusableCell(withIdentifier: "ProdectCell") as! ProdectCell
        if indexPath.section==0 {
            if indexPath.item < marketArray.count && marketArray[indexPath.item] != nil {
                cell.kChartModel = marketArray[indexPath.item]
            }
            return cell
        }
//        if indexPath.section==1 {
//            let cell : SecondViewCell = tableView.dequeueReusableCell(withIdentifier: "SecondViewCell") as! SecondViewCell
//            cell.delegate = self
//            
//            return cell
//        }
//        if indexPath.section == 2 {
//            let cell : ThreeCell = tableView.dequeueReusableCell(withIdentifier: "ThreeCell") as! ThreeCell
//            return cell
//        }
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let price = marketArray[indexPath.item]
            for (index,model) in DealModel.share().productKinds.enumerated(){
                if price.symbol ==  model.symbol{
                    DealModel.share().selectProductIndex = index
                    DealModel.share().selectProduct = model
                    break
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.SelectKind), object: nil, userInfo: nil)
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
        
    }
    //意见反馈
    func jumpToFeedbackController() {
        AppServerHelper.instance().feedbackKid?.makeFeedbackViewController(completionBlock: {[weak self] (controller, error) in
            if let feedbackController = controller{
                let nav = BaseNavigationController.init(rootViewController: feedbackController)
                feedbackController.title = "意见反馈"
                self?.present(nav, animated: true, completion: nil)
            }
        })
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

extension HomeVC:SecondViewCellDelegate, BannerViewDelegate {
    func masterDidClick() {
        tabBarController?.selectedIndex = 2
    }
    
    func banner(_ banner: iCarousel, didSelectItemAt index: Int) {
        let webController = WPWebViewController()
        webController.title = "交易规则"
        let url = Bundle.main.url(forResource: "role.html", withExtension: nil)
        let html = try! String.init(contentsOf: url!, encoding: .utf8)
        let baseUrl = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        webController.webView.loadHTMLString(html, baseURL: baseUrl)
        navigationController?.pushViewController(webController, animated: true)
    }
}
