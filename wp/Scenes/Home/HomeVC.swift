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
import SVProgressHUD

class HomeVC: BaseTableViewController {
    
    //交易明细数据
    lazy var flowListArray: [FlowOrdersList] =  [FlowOrdersList]()
    //行情数据
    lazy var marketArray: [KChartModel] = []
    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var noticeView: NoticeICarousel!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var footErrorView: UIView!
    var priceTimer: Timer?
    var dict:[AnyObject]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let _ = checkLogin()
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
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
        //移除KVO
        DealModel.share().removeObserver(self, forKeyPath: AppConst.KVOKey.allProduct.rawValue)
    }
    //MARK: --DATA
    func initData() {
        AppDataHelper.instance().initProductData()
        let bannerStr = "http://upload-images.jianshu.io/upload_images/961368-77eb018b3fb23d07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
        bannerView.bannerData = ["http://upload-images.jianshu.io/upload_images/961368-e215d5256123aea3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" as AnyObject,bannerStr as AnyObject]
        noticeView.isHidden = true
        
        //每隔3秒请求商品报价
        priceTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(initRealTimeData), userInfo: nil, repeats: AppConst.isRepeate)
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
        if DealModel.share().isFirstGetPrice {
            SVProgressHUD.showProgressMessage(ProgressMessage: "加载中...")
            DealModel.share().isFirstGetPrice = false
        }
        var goods: [AnyObject] = []
        for  product in DealModel.share().productKinds {
            let good = [SocketConst.Key.aType: SocketConst.aType.currency.rawValue,
                        SocketConst.Key.exchangeName: product.exchangeName,
                        SocketConst.Key.platformName: product.platformName,
                        SocketConst.Key.symbol: product.symbol] as [String : Any]
            goods.append(good as AnyObject)
        }
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUserId,
                                    SocketConst.Key.token: UserModel.share().token,
                                    SocketConst.Key.symbolInfos: goods]
        AppAPIHelper.deal().realtime(param: param, complete: { [weak self](result) -> ()? in
            SVProgressHUD.dismiss()
            if let models: [KChartModel] = result as! [KChartModel]?{
                for model in models{
                    for  product in DealModel.share().productKinds{
                        if model.symbol == product.symbol{
                            model.name = product.showSymbol
                        }
                    }
                }
                self?.marketArray = models
                self?.tableView.reloadData()
                if models.count == 0{
                    self?.footErrorView.alpha = 1
                    self?.errorImage.image = UIImage.init(named: "shouye-shujujiazai")
                    self?.errorLabel.text = "正在同步市场实时数据..."
                }else{
                    self?.footErrorView.alpha = 0
                }
            }
            return nil
            }, error: { [weak self](error) -> () in
                self?.errorImage.image = UIImage.init(named: "shouye-shouye-jiazaishibai")
                self?.errorLabel.text = "加载失败"
                self?.footErrorView.alpha = 1
        })
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
    
}

extension HomeVC{
    //MARK: --table's delegate and datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return marketArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : ProdectCell = tableView.dequeueReusableCell(withIdentifier: ProdectCell.className()) as! ProdectCell
        if indexPath.item < marketArray.count {
            cell.kChartModel = marketArray[indexPath.item]
        }
        return cell
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
    
}

extension HomeVC: BannerViewDelegate {

    func banner(_ banner: iCarousel, didSelectItemAt index: Int) {
        let webController = WPWebViewController()
        webController.title = index == 0 ? "航班线路":"交易规则"
        let url = Bundle.main.url(forResource: index == 0 ? "fly.html":"role.html", withExtension: nil)
        let html = try! String.init(contentsOf: url!, encoding: .utf8)
        let baseUrl = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        webController.webView.loadHTMLString(html, baseURL: baseUrl)
        navigationController?.pushViewController(webController, animated: true)
    }
}

extension HomeVC{
    //MARK: --通知
    func registerNotify() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(jumpToDealList), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToDealList), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToRecharge), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToRecharge), object: nil)
        notificationCenter.addObserver(self, selector: #selector(jumpToWithdraw), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToWithdraw), object: nil)
        notificationCenter.addObserver(self, selector: #selector(checkLogin), name: NSNotification.Name(rawValue: AppConst.NoticeKey.logoutNotice.rawValue), object: nil)
        notificationCenter.addObserver(self, selector: #selector(sideHide), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.EnterBackground), object: nil)
        notificationCenter.addObserver(self, selector: #selector(initRequestPrice), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.RequestPrice), object: nil)
    }
    func initRequestPrice() {
        if priceTimer != nil {
            priceTimer?.invalidate()
            priceTimer = nil
        }
        //每隔3秒请求商品报价
        priceTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(initRealTimeData), userInfo: nil, repeats: AppConst.isRepeate)
    }
    func sideHide() {
        if (sideMenuController?.sidePanelVisible)! {
            sideMenuController?.toggle()
        }
    }
    func jumpToRecharge() {
        if checkLogin() {
            performSegue(withIdentifier: EasyRechargeVC.className(), sender: nil)
        }
    }
    func jumpToWithdraw() {
        if checkLogin() {
            performSegue(withIdentifier: WithDrawalVC.className(), sender: nil)
        }
    }
    func jumpToDealList() {
        performSegue(withIdentifier: DealController.className(), sender: nil)
    }
    
   
 
}
