//
//  DealVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
class DealVC: BaseTableViewController, TitleCollectionviewDelegate {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var myQuanLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var upDownView: UIView!
    @IBOutlet weak var winRateConstraint: NSLayoutConstraint!
    @IBOutlet weak var kLineView: KLineView!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var dealTable: MyDealTableView!
    @IBOutlet weak var titleView: TitleCollectionView!
    private var klineBtn: UIButton?
    
    //MARK: --Test
    @IBAction func testItemTapped(_ sender: Any) {
        //        initDealTableData()
        AppDataHelper.instance().initProductData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showTabBarWithAnimationDuration()
    }
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 3) {
            self.winRateConstraint.constant = 100
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
      //  hideTabBarWithAnimationDuration()
    }
    deinit {
        DealModel.share().removeObserver(self, forKeyPath: "selectDealModel")
    }
    //MARK: --DATA
    func initData() {
        //初始化持仓数据
        initDealTableData()
        //初始化下商品数据
//        initProductData()
        //持仓点击
        DealModel.share().addObserver(self, forKeyPath: "selectDealModel", options: .new, context: nil)
        DealModel.share().addObserver(self, forKeyPath: "allProduct", options: .new, context: nil)
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
            let allProducets: [ProductModel] = DealModel.share().allProduct
            titleView.objects = allProducets
//            let product = allProducets[0]
//            DealModel.share().selectProduct = product
//            didSelectedObject(object: product)
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
    // 当前商品列表数据
    func initProductData() {
        var allProducets: [ProductModel] = []
        AppAPIHelper.deal().products(pid: 0, complete: { [weak self](result) -> ()? in
            
            if let products: [ProductModel] = result as! [ProductModel]?{
                allProducets += products
                self?.titleView.objects = allProducets
                let product = allProducets[0]
                DealModel.share().selectProduct = product
                self?.didSelectedObject(object: product)
            }
            return nil
        }, error: errorBlockFunc())
    }
    // 持仓列表数据
    func initDealTableData() {
        AppAPIHelper.deal().currentDeals(complete: { [weak self](result) -> ()? in
            if result == nil{
                return nil
            }
            if let resultModel: [PositionModel] = result as! [PositionModel]?{
                self?.dealTable.dealTableData = resultModel
            }
            return nil
            }, error: errorBlockFunc())
    }
    // 当前报价
    internal func didSelectedObject(object: AnyObject?) {
        if let model: ProductModel = object as! ProductModel? {
            DealModel.share().selectProduct = model
            initRealTimeData()
            kLineView.refreshKLine()
        }
    }
    func initRealTimeData() {
        if let product = DealModel.share().selectProduct {
            let good = [SocketConst.Key.goodType: product.typeCode,
                        SocketConst.Key.exchangeName: product.exchangeName,
                        SocketConst.Key.platformName: product.platformName]
            let param: [String: Any] = [SocketConst.Key.id: UserModel.currentUserId,
                                        SocketConst.Key.token: UserModel.token ?? "",
                                        SocketConst.Key.goodsinfos: [good]]
            AppAPIHelper.deal().realtime(param: param, complete: { [weak self](result) -> ()? in
                if let models: [KChartModel] = result as! [KChartModel]?{
                    for model in models{
                        if model.goodType != product.typeCode{
                            return nil
                        }
                        self?.priceLabel.text = String.init(format: "%.2f", model.currentPrice)
                        self?.highLabel.text = String.init(format: "%.2f", model.highPrice)
                        self?.lowLabel.text = String.init(format: "%.2f", model.lowPrice)
                        self?.openLabel.text = String.init(format: "%.2f", model.openingTodayPrice)
                        self?.closeLabel.text = String.init(format: "%.2f", model.closedYesterdayPrice)
                        self?.nameLabel.text = "\(model.name)(元/千克)"
                    }
                }
                return nil
                }, error: errorBlockFunc())
        }
    }
    
    //MARK: --UI
    func initUI() {
        timeBtnTapped(minBtn)
        titleView.itemDelegate = self
        titleView.reuseIdentifier = ProductTitleItem.className()
    }
    
    //MARK: --商品选择
    func didSelectedObjects(object: AnyObject?) {
        if let product = object as? ProductModel {
            DealModel.share().selectProduct = product
        }
    }
    
    //MARK: --KlineView and Btns
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        if let btn = klineBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        
        kLineView.selectIndex = sender.tag
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
        klineBtn = sender
    }
    
    //MARK: --买涨/买跌
    @IBAction func dealBtnTapped(_ sender: UIButton) {
        if checkLogin(){
            if DealModel.share().selectProduct == nil {
                SVProgressHUD.showWainningMessage(WainningMessage: "暂无商品信息", ForDuration: 1.5, completion: nil)
                return
            }
            DealModel.share().dealUp = sender.tag == 1
            DealModel.share().isDealDetail = false
            performSegue(withIdentifier: BuyVC.className(), sender: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == BuyVC.className() {
            return checkLogin()
        }
        return true
    }
}
