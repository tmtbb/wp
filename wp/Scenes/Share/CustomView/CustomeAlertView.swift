//
//  CustomeAlertView.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class CustomeAlertView : UIView,UITableViewDelegate,UITableViewDataSource {
    
    //大背景view
    
    var bgView = UIView()
    
    var tableView = UITableView()
    
    var dateArr = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // dateBtn.frame = CGRect.init(x: self.view.frame.size.width-100, y: 10, width: 80, height: 20)
        tableView = UITableView.init(frame: CGRect.init(x:self.frame.size.width-120, y:40, width: 110, height: 0), style: UITableViewStyle.plain)
        
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        
        tableView.clipsToBounds = true
        
        tableView.layer.cornerRadius = 5;
        
        tableView.dataSource = self
        
        self.addSubview(tableView)
        
        bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.1);
        
        self.addSubview(bgView)
        
        self.addSubview(tableView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(removeFromView))
        
        bgView.addGestureRecognizer(tap)
        
        tableView.removeGestureRecognizer(tap)
        addAnimation()
        
    }
    
    func removeFromView(){
        
        ShareModel.share().selectMonth = "\(1000000)"
        UIView.animate(withDuration: 0.25) {
            
            self.removeFromSuperview()
        }
        
    }
    
    func addAnimation(){
        
        UIView.animate(withDuration: 0.25) {
            self.tableView.frame = CGRect.init(x:self.frame.size.width-120, y:40, width: 110, height: 200)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 20
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let Cell :UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        
        
        
        
        Cell.textLabel?.text = "1232131"
        
        Cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        Cell.textLabel?.textColor = UIColor.init(hexString: "333333")
        return Cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        ShareModel.share().selectMonth = "\(indexPath.row)"
        
        UIView.animate(withDuration: 0.1) {
           self.removeFromSuperview()
        }
       
    }
    
}
