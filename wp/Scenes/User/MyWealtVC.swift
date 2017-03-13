//
//  MyWealtVC.swift
//  wp
//
//  Created by sum on 2017/1/17.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
import Charts
class MyWealtVCCell: OEZTableViewCell {
    //时间lab
    @IBOutlet weak var timeLb: UILabel!
    //第一个lab
    @IBOutlet weak var firstLb: UILabel!
    //第二个lab
    @IBOutlet weak var secondLb: UILabel!
    //第三个lab
    @IBOutlet weak var threeLb: UILabel!
    //第一个lab金额
    @IBOutlet weak var firstMoneyLb: UILabel!
    //第二个lab金额
    @IBOutlet weak var secondMoneyLb: UILabel!
    //第三个lab金额
    @IBOutlet weak var threeMoneyLb: UILabel!
   
    override func update(_ data: Any!) {
        
        let dic = data as! NSDictionary
        if dic.allKeys.count > 0{
            timeLb.text =  "\(dic.allKeys[0])"
            let arr : NSArray =  dic[dic.allKeys[0]] as! NSArray
            // 有一个数据
            if arr.count == 1 {
                
                let dic : NSDictionary = arr[0] as! NSDictionary
                firstLb.text = dic["name"] as? String
                
                let firststr  = String(format: "%.2f", dic["profit"] as! Double)
                firstMoneyLb.text = firststr
                firstMoneyLb.textColor = firststr.range(of: "-") != nil ? UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
            }
                // 有两个个数据
            else if arr.count == 2 {
                
                let dic : NSDictionary = arr[0] as! NSDictionary
                firstLb.text = dic["name"] as? String
                
                let firststr  = String(format: "%.2f", dic["profit"] as! Double)
                firstMoneyLb.text = firststr
                firstMoneyLb.textColor = firststr.range(of: "-") != nil ?UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
                
                let dic1 : NSDictionary = arr[1] as! NSDictionary
                secondLb.text = dic1["name"] as? String
                
                let secondstr  = String(format: "%.2f", dic1["profit"] as! Double)
                secondMoneyLb.text = secondstr
                secondMoneyLb.textColor = secondstr.range(of: "-") != nil ? UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
            }
                // 有三个数据
            else {
                let dic : NSDictionary = arr[0] as! NSDictionary
                firstLb.text = dic["name"] as? String
                
                let dic1 : NSDictionary = arr[1] as! NSDictionary
                secondLb.text = dic1["name"] as? String
                
                let dic2 : NSDictionary = arr[2] as! NSDictionary
                threeLb.text = dic2["name"] as? String
                
                let firststr  = String(format: "%.2f", dic["profit"] as! Double)
                firstMoneyLb.text = firststr
                firstMoneyLb.textColor = firststr.range(of: "-") != nil ? UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
                
                let secondstr  = String(format: "%.2f", dic1["profit"] as! Double)
                secondMoneyLb.text = secondstr
                secondMoneyLb.textColor = secondstr.range(of: "-") != nil ? UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
                
                let threestr  = String(format: "%.2f", dic2["profit"] as! Double)
                threeMoneyLb.text = threestr
                threeMoneyLb.textColor = threestr.range(of: "-") != nil ?UIColor.init(hexString: "0EAF56") : UIColor.init(hexString: "E9573F")
            }
            
        }
        
    }
}
class MyWealtVC: BaseCustomPageListTableViewController {
    //头部背景
    @IBOutlet weak var headBg: UIView!
    //  提现按钮
    @IBOutlet weak var withDraw: UIButton!
    //  充值按钮
    @IBOutlet weak var recharge: UIButton!
    //  月份label
    var monthLb  : UILabel = UILabel()
    //  账户余额
    @IBOutlet weak var account: UILabel!
    
    // 定义一个数组来放数据
    var dataArry = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headBg.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        title  = "我的资产"
        recharge.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        recharge.layer.cornerRadius = 5
        recharge.clipsToBounds = true
        initdata()
    }
    //MARK: --界面加载请求方法 保证数据的最新性
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: false)
        hideTabBarWithAnimationDuration()

    }
    func initdata(){
         if UserModel.share().getCurrentUser() != nil{
            let str : String =  String.init(format:  "%.2f", (UserModel.share().getCurrentUser()?.balance)!)
            let int : Double = Double(str)!
            
            let format = NumberFormatter()
            format.numberStyle = .currency
            let account : String =   format.string(from: NSNumber(value: int))!
            self.account.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "￥").last?.components(separatedBy: "$").last)! + "元"
            
        }
        AppAPIHelper.user().accinfo(complete: {[weak self] (result) -> ()? in
            if let resultDic = result as? [String: AnyObject] {
                if let money = resultDic["balance"] as? Double{
                    
                    UserModel.updateUser(info: { (result) -> ()? in
                        UserModel.share().getCurrentUser()?.balance = Double(money)
                        return nil
                    })
                    let format = NumberFormatter()
                    format.numberStyle = .currency
                    let account : String = format.string(from: NSNumber(value: (UserModel.share().getCurrentUser()?.balance)!))!
                    self?.account.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "$").last)!
                    self?.account.text =  (account.components(separatedBy: "¥").last?.components(separatedBy: "￥").last?.components(separatedBy: "$").last)!
                }
            }
            return nil
            }, error: errorBlockFunc())
    }
    //MARK: --界面销毁删除监听机制
    deinit {
        ShareModel.share().shareData.removeAll()
    }
    //MARK: --网络请求
    override func didRequest(_ pageIndex : Int) {

        didRequestComplete(nil)

//        let index = (pageIndex - 1) * 10
//        AppAPIHelper.user().everyday(start: Int32(index), count: 10, complete: { [weak self](result) -> ()? in
//            if result != nil{
//                if pageIndex == 1{
//                    if let _ = result?["everyday"] as? [AnyObject]{
//                        self?.dataArry = result?["everyday"] as! Array
//                    }
//                }else{
//                    if let _ = result?["everyday"] as? [AnyObject]{
//                        self?.dataArry  =  (self?.dataArry)! + (result?["everyday"] as! Array)
//                    }
//                }
//                self?.didRequestComplete( result?["everyday"] as AnyObject)
//                
//            }
//            return nil
//            }, error: errorBlockFunc())
        
        
    }
    //MARK: --tableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        //读取数据来判断当天的记录
        let dic : NSDictionary = self.dataArry[indexPath.row] as! NSDictionary
        //读取数据来判断当天的记录
        let string = dic.allKeys[0]
        let arr : NSArray = dic[string] as! NSArray
        return arr.count == 0 ? 0 : (arr.count == 1 ? 38 : (arr.count == 2) ? 65 : 93)

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerView  : UIView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
        
        headerView.backgroundColor = UIColor.groupTableViewBackground
        
        monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
        if section==0 {
            monthLb.text = "收益情况"
        }else{
            monthLb.text = "昨日收益"
        }
        monthLb.textColor = UIColor.init(hexString: "333333")
        monthLb.font = UIFont.systemFont(ofSize: 16)
        
        headerView.addSubview(monthLb)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 40
    }
    //MARK: --充值按钮的点击事件
    @IBAction func recharge(_ sender: Any) {
        recharge.isSelected = true
        withDraw.isSelected = false
        self.performSegue(withIdentifier: "PushToRechage", sender: nil )
    }
    //MARK: --提现按钮的点击事件
    @IBAction func withDraw(_ sender: Any) {
        recharge.isSelected = false
        withDraw.isSelected = true
        self.performSegue(withIdentifier: "PushWithdraw", sender: nil )
    }
    
    
}
