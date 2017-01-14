
//
//  RechargeListvc.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//OEZTableViewCell
class RechargeListVCCell: OEZTableViewCell {
    
    @IBOutlet weak var weekLb: UILabel!            // 姓名LbstatusLb
    @IBOutlet weak var timeLb: UILabel!            // 时间Lb
    @IBOutlet weak var moneyCountLb: UILabel!      // 充值金额Lb
    // 状态Lb
    @IBOutlet weak var statusLb: UILabel!
    @IBOutlet weak var minuteLb: UIButton!         // 分秒
    @IBOutlet weak var bankLogo: UIImageView!      // 银行卡图片
    
    @IBOutlet weak var withDrawto: UILabel!
    
    
    // 刷新cell
    override func update(_ data: Any!) {
        let model = data as! Model
        self.moneyCountLb.text = "\(model.amount)"
        self.withDrawto.text = model.depositType == 0 ? "微信" :"提现至银行卡"
        self.timeLb.text = "\(model.depositTime)"
        self.statusLb.text = "充值失败"
        
    }
}

class RechargeListVC: BasePageListTableViewController {
    
    //定义全局的数组装 model
    // var data :  RechargeListModel!
    
    //用来接收偏移量
    var contentoffset = CGFloat()
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNumber = 0
        title = "充值列表"
        
        ShareModel.share().addObserver(self, forKeyPath: "selectMonth", options: .new, context: nil)
    }
    
    //MARK:  界面销毁删除监听
    deinit {
        ShareModel.share().removeObserver(self, forKeyPath: "selectMonth", context: nil)
        ShareModel.share().shareData.removeAll()
    }
    
    //MARK: 监听键值对
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "selectMonth" {
            
            if let base = change? [NSKeyValueChangeKey.newKey] as? String {
                
                self.tableView.isScrollEnabled = true
                if base != "1000000" {
                }
                
                print(base)
                
            }
        }
    }
    //MARK: 网络请求列表
    override func didRequest(_ pageIndex : Int) {
        
        // pageNumber = pageNumber +1
        AppAPIHelper.user().creditlist(status: "", pos: 0, count: 10, complete: {[weak self] (result) -> ()? in
            
            if let object = result {
                let Model : RechargeListModel = object as! RechargeListModel
                self?.didRequestComplete(Model.depositsinfo as AnyObject)
            }else{
                self?.didRequestComplete(nil)
            }
            return nil
            }, error: errorBlockFunc())
        
    }
    //MARK: ---tableView delegate和datasourcec
    override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerView  = UIView ()
        if section == 0 {
            let  headerView  : UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
            
            headerView.backgroundColor = UIColor.groupTableViewBackground
            
            let  monthLb  :  UILabel = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
            monthLb.text = "2017 年 01 月"
            
            monthLb.textColor = UIColor.init(hexString: "333333")
            
            monthLb.font = UIFont.systemFont(ofSize: 16)
            
            headerView.addSubview(monthLb)
            
            let dateBtn :UIButton  = UIButton.init(type: UIButtonType.custom)
            
            dateBtn.frame = CGRect.init(x: self.view.frame.size.width-80, y: 8, width: 23, height: 23)
            
            dateBtn.setBackgroundImage(UIImage.init(named: "calendar"), for: UIControlState.normal)
            dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            dateBtn.addTarget(self, action: #selector(selectDate), for: UIControlEvents.touchUpInside)
            
            headerView.addSubview(dateBtn)
            return headerView
            
        }
        
        
        return headerView
    }
    
    override   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 40
    }
    override  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 0.1
        
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        contentoffset   = scrollView.contentOffset.y
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    //MARK: ---视图添加
    func selectDate(){
        
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: contentoffset, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.tableView.isScrollEnabled = false
        self.view.addSubview(customer)
    }
    
}







