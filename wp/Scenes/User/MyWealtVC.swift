//
//  MyWealtVC.swift
//  wp
//
//  Created by sum on 2017/1/7.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
class MyWealtVCCell: UITableViewCell {
    @IBOutlet weak var LB: UILabel!
    
}
class MyWealtVC: BaseListTableViewController {
    var headerView : UIView = UIView()
    
    
    var monthLb  : UILabel = UILabel()
     override func viewDidLoad() {
        super.viewDidLoad()
      //注册cell
        
        
      
        headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
        
        
        monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
        monthLb.text = "12 月"
        
        headerView.addSubview(monthLb)
        
    }
    override func didRequest() {
              didRequestComplete([] as AnyObject)
//        
//        //注释掉  请求接口有的时候再打开
//        //        AppAPIHelper.share().getShareData(userId: "123", phone: "15306559323", selectIndex: "1223", pageNumber: "0", complete: { (result ) -> ()? in
//        //
//        //            return nil
//        //        }, error: errorBlockFunc())
//        //        print(errorBlockFunc)
//        
//        
  }
        override func numberOfSections(in tableView: UITableView) -> Int{
    
            return 10
     }

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 10
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if section == 0 {
            headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
            
            
            monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
            monthLb.text = "12 月"
            
            headerView.addSubview(monthLb)
            
            self.monthLb.text = "本月收益"
            return headerView
            
        }
        if section == 1 {
            
            headerView = UIView.init(frame:CGRect.init(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
            
            
            monthLb = UILabel.init(frame: CGRect.init(x: 17, y: 0, width: self.view.frame.size.width, height: 40))
            monthLb.text = "12 月"
            
            headerView.addSubview(monthLb)
            self.monthLb.text = "12"
            return headerView
            
        }
        
        return headerView
    }
    override   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    
        return 40
    }
   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    
        return 0.1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWealtVCCell", for: indexPath)


        return cell
    }
    


}
