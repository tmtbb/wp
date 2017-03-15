
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
//    override func isOverspreadLoadMore() -> Bool {
//        return false
//    }
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
        
        
        
        AppAPIHelper.user().creditlist(status: 0, pos: Int32((pageIndex - 1) * 10) , count: 10, complete: {[weak self] (result) -> ()? in
            
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
    
    //    override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        let  headerView  = UIView ()
    //        if section == 0 {
    //            let  headerView  : UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
    //            headerView.backgroundColor = UIColor.groupTableViewBackground
    //            monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
    //            monthLb.text = "2017年 1月"
    //            monthLb.textColor = UIColor.init(hexString: "333333")
    //            monthLb.font = UIFont.systemFont(ofSize: 16)
    //
    //            headerView.addSubview(monthLb)
    //
    //            let dateBtn :UIButton  = UIButton.init(type: UIButtonType.custom)
    //
    //            dateBtn.frame = CGRect.init(x: self.view.frame.size.width-60, y: 8, width: 23, height: 23)
    //
    //            dateBtn.setBackgroundImage(UIImage.init(named: "calendar"), for: UIControlState.normal)
    //            dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    //
    //            dateBtn.addTarget(self, action: #selector(selectDate), for: UIControlEvents.touchUpInside)
    //
    //            headerView.addSubview(dateBtn)
    //            return headerView
    //
    //        }
    //
    //
    //        return headerView
    //    }
    //
    //    override   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    //
    //        return 40
    //    }
    //    override  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    //
    //        return 0.1
    //
    //    }
    
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







