
//
//  RechargeListvc.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//OEZTableViewCell  UItableViewCell
class RechargeListVCCell: OEZTableViewCell {
    
    // 姓名Lb
    @IBOutlet weak var nameLb: UILabel!
    
    // 时间Lb
    @IBOutlet weak var timeLb: UILabel!
    
    // 充值金额Lb
    @IBOutlet weak var moneyCountLb: UILabel!
    
    // 状态Lb
    @IBOutlet weak var statusLb: UILabel!
    
    
   
    
    // 刷新cell
    override func update(_ data: Any!) {
        
//        let model =  data as! RechargeListModel
//        //打印输出 model.rid
//        let  s =  String(format: "%x", model.rid)
//        print(s)
//        moneyCountLb.text = s;
        
        
    }
    
    
}

class RechargeListVC: BasePageListTableViewController {
    
    /**定义全局的数组装 model**/
    // var data :  RechargeListModel!
    
    //用来接收偏移量
     var contentoffset = CGFloat()
    /** 用来判断刷新列表页第几页 **/
    var pageNumber : Int = 0
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
        
        AppAPIHelper.user().creditlist(status: "", pos: 0, count: 10, complete: {[weak self] (result) -> ()? in
           self?.didRequestComplete(["",""] as AnyObject)
            
            return nil
            
            }, error: errorBlockFunc())
        
    }
    
    //MARK: ---tableView代理
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerView  = UIView ()
        if section == 0 {
            let  headerView  : UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
            
            headerView.backgroundColor = UIColor.groupTableViewBackground
            
            let  monthLb  :  UILabel = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
            monthLb.text = "2017 年 01 月"
            
            monthLb.textColor = UIColor.init(hexString: "333333")
            
            monthLb.font = UIFont.systemFont(ofSize: 15)
            
            headerView.addSubview(monthLb)
            
            
            let dateBtn :UIButton  = UIButton.init(type: UIButtonType.custom)

//            dateBtn.setTitle("", for: <#T##UIControlState#>)
            dateBtn.frame = CGRect.init(x: self.view.frame.size.width-100, y: 10, width: 80, height: 20)
            
            dateBtn.backgroundColor = UIColor.red
            dateBtn.setTitle("月份", for: UIControlState.normal)
            
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
    
    //MARK: ---视图添加

    func chooseDate(){
        
    
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: contentoffset, width: self.view.frame.size.width, height: self.view.frame.size.height))

          self.tableView.isScrollEnabled = false
          self.view.addSubview(customer)
        
        
//        appdele.window?.addSubview(customer)
        
    }
    
    
}







