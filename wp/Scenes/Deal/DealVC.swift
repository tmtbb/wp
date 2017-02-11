//
//  DealVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
class DealVC: BaseTableViewController, TitleCollectionviewDelegate {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var myMoneyView: UIView!
    @IBOutlet weak var myQuanLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePerLabel: UILabel!
    @IBOutlet weak var kLineView: KLineView!
    @IBOutlet weak var dealTable: MyDealTableView!
    @IBOutlet weak var titleView: TitleCollectionView!
    @IBOutlet weak var klineTitleView: TitleCollectionView!
    @IBOutlet weak var productsView: ProductsiCarousel!
    private var klineBtn: UIButton?
    private var priceTimer: Timer?
    private var klineTimer: Timer?
    let klineTitles = ["分时图","5分K","15分K","30分K","1小时K"]
    //MARK: --Test
    @IBAction func testItemTapped(_ sender: Any) {
        //        initDealTableData()
        AppDataHelper.instance().initProductData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showTabBarWithAnimationDuration()
        if let money = UserModel.share().currentUser?.balance{
            myMoneyLabel.text = String.init(format: "%.2f", money)
        }
    }
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
      //  hideTabBarWithAnimationDuration()
    }
    deinit {
        DealModel.share().removeObserver(self, forKeyPath: "selectDealModel")
        priceTimer?.invalidate()
        priceTimer = nil
        klineTimer?.invalidate()
        klineTimer = nil
    }
    //MARK: --DATA
    func initData() {
        //初始化持仓数据
        initDealTableData()
        YD_CountDownHelper.shared.countDownWithDealTableView(tableView: dealTable)

        //初始化下商品数据
        titleView.objects = DealModel.share().productKinds
        if let selectProduct = DealModel.share().selectProduct{
            didSelectedObject(titleView, object: selectProduct)
        }
        //每隔3秒请求商品报价
        priceTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(initRealTimeData), userInfo: nil, repeats: true)
        //持仓点击
        DealModel.share().addObserver(self, forKeyPath: "selectDealModel", options: .new, context: nil)
        DealModel.share().addObserver(self, forKeyPath: "allProduct", options: .new, context: nil)
        //k线选择器
        klineTitleView.objects = klineTitles as [AnyObject]?
        if let flowLayout: UICollectionViewFlowLayout = klineTitleView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize.init(width: UIScreen.width()/CGFloat(klineTitles.count), height: 40)
            
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selectDealModel" {
            if DealModel.share().type == .btnTapped {
                //平仓
                let pwdAlter = UIAlertController.init(title: "平仓", message: "请输入交易密码", preferredStyle: .alert)
                pwdAlter.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = "请输入交易密码"
                    textField.isSecureTextEntry = true
                })
                let sureAction = UIAlertAction.init(title: "确认", style: .default, handler: { [weak self](result) in
                    //校验密码
                    AppAPIHelper.deal().sellOutDeal(complete: {(result) -> ()? in
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "平仓成功", ForDuration: 1.5, completion: nil)
                        return nil
                    }, error: self?.errorBlockFunc())
                })
                let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
                pwdAlter.addAction(sureAction)
                pwdAlter.addAction(cancelAction)
                present(pwdAlter, animated: true, completion: nil)
                return
            }
            
            if DealModel.share().type == .cellTapped {
                //修改持仓
                DealModel.share().isDealDetail = true
                performSegue(withIdentifier: BuyVC.className(), sender: nil)
                return
            }
        }
        
        if keyPath == "allProduct"{
            let allProducets: [ProductModel] = DealModel.share().productKinds
            titleView.objects = allProducets
        }
    }
    //MARK: --我的资产
    @IBAction func jumpToMyWallet(_ sender: AnyObject) {
        if checkLogin(){
            let storyboard = UIStoryboard.init(name: "Share", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: MyWealtVC.className())
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    //TitleCollectionView's Delegate
    internal func didSelectedObject(_ collectionView: UICollectionView, object: AnyObject?) {
        if collectionView == titleView {
            if let model: ProductModel = object as? ProductModel {
                DealModel.share().selectProduct = model
                AppDataHelper.instance().initLineChartData()
                initRealTimeData()
                kLineView.refreshKLine()
                reloadProducts()
            }
        }
        
        if collectionView ==  klineTitleView{
            if let klineTitle = object as? String{
                for (index, title) in klineTitles.enumerated() {
                    if title == klineTitle {
                        kLineView.selectIndex = index
                        break
                    }
                }
            }
        }
        
        
    }
    

    
    func reloadProducts() {
        var products: [ProductModel] = []
        for product in DealModel.share().allProduct {
            if product.symbol == DealModel.share().selectProduct!.symbol{
                products.append(product)
            }
        }
        productsView.objects = products
    }
    // 持仓列表数据
    func initDealTableData() {
        AppAPIHelper.deal().currentDeals(complete: { [weak self](result) -> ()? in
            if result == nil{
                return nil
            }
            if let resultModel: [PositionModel] = result as! [PositionModel]?{
//                self?.dealTable.dealTableData = resultModels
            }
            return nil
            }, error: errorBlockFunc())
    }
    // 当前报价
    func initRealTimeData() {
        if let product = DealModel.share().selectProduct {
            let good = [SocketConst.Key.aType: SocketConst.aType.currency.rawValue,
                        SocketConst.Key.exchangeName: product.exchangeName,
                        SocketConst.Key.platformName: product.platformName,
                        SocketConst.Key.symbol: product.symbol] as [String : Any]
            let param: [String: Any] = [SocketConst.Key.id: UserModel.currentUserId,
                                        SocketConst.Key.token: UserModel.token ?? "",
                                        SocketConst.Key.symbolInfos: [good]]
            AppAPIHelper.deal().realtime(param: param, complete: { [weak self](result) -> ()? in
                if let models: [KChartModel] = result as! [KChartModel]?{
                    for model in models{
                        self?.priceLabel.text = String.init(format: "%.4f", model.currentPrice)
                        self?.highLabel.text = String.init(format: "%.4f", model.highPrice)
                        self?.lowLabel.text = String.init(format: "%.4f", model.lowPrice)
                        self?.openLabel.text = String.init(format: "%.4f", model.openingTodayPrice)
                        self?.closeLabel.text = String.init(format: "%.4f", model.closedYesterdayPrice)
                        self?.nameLabel.text = "\(model.name)(元/千克)"
                        self?.changePerLabel.text = String.init(format: "%.4f", model.change)
                        self?.changeLabel.text = String.init(format: "%.2f%%", model.change/model.currentPrice * 100)
                        let colorKey = model.change > 0 ? AppConst.Color.buyUp : AppConst.Color.buyDown
                        self?.changeLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
                        self?.changePerLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
                        self?.priceLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
                    }
                }
                return nil
                }, error: errorBlockFunc())
        }
    }
    
    //MARK: --UI
    func initUI() {
        myMoneyView.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        titleView.itemDelegate = self
        titleView.reuseIdentifier = ProductTitleItem.className()
        
        klineTitleView.itemDelegate = self
        klineTitleView.reuseIdentifier = KLineTitleItem.className()
    }
    
   
    //MARK: --买涨/买跌
    @IBAction func dealBtnTapped(_ sender: UIButton) {
        if true || checkLogin(){
            tableView.scrollToRow(at: IndexPath.init(row: 3, section: 0), at: .top, animated: false)
            
            if DealModel.share().selectProduct == nil {
                SVProgressHUD.showWainningMessage(WainningMessage: "暂无商品信息", ForDuration: 1.5, completion: nil)
                return
            }
            DealModel.share().dealUp = sender.tag == 1
            DealModel.share().isDealDetail = false
//            performSegue(withIdentifier: BuyVC.className(), sender: nil)
            
            let controller = UIStoryboard.init(name: "Deal", bundle: nil).instantiateViewController(withIdentifier: BuyProductVC.className())
            controller.modalPresentationStyle = .custom
            present(controller, animated: true, completion: nil)
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == BuyVC.className() {
            return checkLogin()
        }
        return true
    }
}
