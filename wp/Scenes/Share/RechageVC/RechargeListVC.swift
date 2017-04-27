
//
//  RechargeListvc.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class RechargeListVCCell: OEZTableViewCell {
    
    @IBOutlet weak var weekLb: UILabel!            // 姓名LbstatusLb
    @IBOutlet weak var timeLb: UILabel!            // 时间Lb
    @IBOutlet weak var moneyCountLb: UILabel!      // 充值金额Lb
    @IBOutlet weak var statusLb: UILabel!          // 状态Lb
    @IBOutlet weak var minuteLb: UILabel!          // 分秒
    @IBOutlet weak var bankLogo: UIImageView!      // 银行卡图片
    @IBOutlet weak var withDrawto: UILabel!        // 提现至
    //MARK:--- 刷新cell
    override func update(_ data: Any!) {
        let model = data as! Model
        self.moneyCountLb.text = "+" + " "  + String.init(format: "%.2f", model.amount)
        let timestr : Int = Date.stringToTimeStamp(stringTime: model.depositTime)
        self.withDrawto.text = model.depositType == 1 ? "微信支付" :"银行卡"
        self.weekLb.text = Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "yyyy")
        self.statusLb.text = model.status == 1 ? "处理中" : (model.status == 2 ?  "充值成功":  "充值失败")
        self.timeLb.text =  Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "MM-dd")
        self.minuteLb.text =  Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "HH:mm:ss")
        
//        BankLogoColor.share().checkLocalBank(string: model.ba)
        self.bankLogo.image = model.depositType == 1 ? UIImage.init(named: "weixinpay") : (UIImage.init(named: "unionPay"))
        //        print(model.status)
        // 设置失败的cell的背景alpha  根据status 来判断 状态view
        //        self.backgroundColor = UIColor.groupTableViewBackground
        self.alpha = model.status == 2 ? 1 :  (model.status == 1 ? 1 : 0.6)
    }
}

class RechargeListVC: BasePageListTableViewController {
    
    
    var contentoffset = CGFloat()          //用来接收偏移量
    var pageNumber : Int = 0               //用来判断刷新列表页第几页
    var  monthLb  = UILabel()              // 设置显示的月份的label
    var dataModel = [Model]()              //来接收全局的数组
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNumber = 0
        title = "充值列表"
        self.setIsLoadMore(true)
        ShareModel.share().addObserver(self, forKeyPath: "selectMonth", options: .new, context: nil)
    }
    //MARK:  界面销毁删除监听
    deinit {
        ShareModel.share().removeObserver(self, forKeyPath: "selectMonth", context: nil)
    }

    //MARK: 监听键值对
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "selectMonth" {
            
            if let selectMonth = change? [NSKeyValueChangeKey.newKey] as? String {
                
                self.tableView.isScrollEnabled = true
                if selectMonth != "1000000" {
                    monthLb.text = "2017年" + " " + "\(selectMonth)" + "月"
                }
            }
        }
    }
    //MARK: 网络请求列表
    override func didRequest(_ pageIndex : Int) {
        
        let param = BalanceListParam()
        param.startPos = pageIndex == 1 ? 0 : dataSource == nil ? 0 : dataSource!.count+1
        param.count = 10
        AppAPIHelper.user().creditlist(param: param, complete: {[weak self] (result) -> ()? in
            
            if let object = result {
                let Model : RechargeListModel = object as! RechargeListModel
                if pageIndex == 1{
                    self?.dataModel =  Model.depositsinfo!
                }else{
                    self?.dataModel  =   (self?.dataModel)! + Model.depositsinfo!
                }
                self?.didRequestComplete(Model.depositsinfo as AnyObject)
            }else{
                self?.didRequestComplete(nil)
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    //MARK: ---视图添加
    func selectDate(){
        
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: contentoffset, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.tableView.isScrollEnabled = false
        self.view.addSubview(customer)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        contentoffset   = scrollView.contentOffset.y
    }
    
}







