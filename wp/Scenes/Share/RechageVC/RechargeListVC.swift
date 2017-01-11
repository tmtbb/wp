
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
    
    @IBOutlet weak var weekLb: UILabel!            // 姓名Lb
    @IBOutlet weak var timeLb: UILabel!            // 时间Lb
    @IBOutlet weak var moneyCountLb: UILabel!      // 充值金额Lb
    @IBOutlet weak var statusLb: UIButton!         // 状态Lb
    @IBOutlet weak var minuteLb: UIButton!         // 分秒
    @IBOutlet weak var bankLogo: UIImageView!      // 银行卡图片
    
    @IBOutlet weak var withDrawto: UILabel!
    
    
    // 刷新cell
    override func update(_ data: Any!) {
        
        
        let model = data as! Model
        
        self.moneyCountLb.text = model.money
        
        self.withDrawto.text = model.depositType == 1 ? "提现至微信" :"提现至银行卡"
        
        self.timeLb.text = "\(model.depositTime)"
        
        //        let model =  data as! RechargeListModel
        //        //打印输出 model.rid
        //        let  s =  String(format: "%x", model.rid)
        //        print(s)
        //        moneyCountLb.text = s;
        
        
    }
    
    
}

class RechargeListVC: BasePageListTableViewController {
    
    //定义全局的数组装 model
    // var data :  RechargeListModel!
    
    //用来接收偏移量
    var contentoffset = CGFloat()
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 移除监听选择月份的按钮触发事件
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ShareModel().selectType), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "充值列表"
        // 监听
        NotificationCenter.default.addObserver(self, selector: #selector(vaulechange(_:)), name: NSNotification.Name(rawValue: ShareModel().selectMonth), object: nil)
        
    }
    func vaulechange(_ notice: NSNotification) {
        
        let errorCode: Int = (notice.object as? Int)!
        self.tableView.isScrollEnabled = true
        print(errorCode)
        
        
    }
    //测试充值列表
    override func didRequest(_ pageIndex : Int) {
        
        AppAPIHelper.user().creditlist(status: "1,3", pos: 0, count: 10, complete: {[weak self] (result) -> ()? in
            
            let Model : RechargeListModel = result as! RechargeListModel
            self?.didRequestComplete(Model.depositsinfo as AnyObject)
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
            
            dateBtn.addTarget(self, action: #selector(chooseDate), for: UIControlEvents.touchUpInside)
            
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
    
    func chooseDate(){
        
        
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: contentoffset, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.tableView.isScrollEnabled = false
        self.view.addSubview(customer)
        
        
    }
    
    
}







