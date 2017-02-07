//
//  chartView.swift
//  wp
//
//  Created by sum on 2017/1/17.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit



class ChartView: UIView {
    
    
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var first: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    func setupSubviews(){
        
        initUI()
        reloadData(dic: ["":"" as AnyObject])
        //        self.addSubview(view)
    }
    
    //MARK-设置UI数据
    func initUI(){
        
        //移除所有的控件防止重复添加
        
        //中间分割线
        let  line : UILabel = UILabel.init(frame: CGRect.init(x: 17, y: self.frame.size.height/2 - 10, width: UIScreen.main.bounds.size.width - 34, height: 0.5))
        
        
        self.addSubview(line)
        
        line.backgroundColor = UIColor.init(hexString: "666666")
        
        // 设置frame -是下面的线
        // 向下不用减 向上 需要减 lab的高度  70 为最高 所以每个高度为 70*百分比
        
        for index in 0...5{
            
            let float : CGFloat = CGFloat.init(index)
            //            let oringnWith = ((UIScreen.main.bounds.size.width - 5*30)/6.0) * float + 30 * float - 30
            //设置画柱状图
            let tree = UILabel.init()
            
            let amount = UILabel.init()
            
            tree.frame =   CGRect.zero
            tree.tag = index + 100
            //            if index == 2 {
            //                tree.frame =   CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0 - 10*float-20, width: 30, height:  10*float+20)
            //            }else{
            
            // 涨率
            tree.backgroundColor = UIColor.init(hexString: "E9573E")
            
            amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: self.frame.size.height/2.0  - 10 * float - 20 - 50  , width:   40, height: 20)
            amount.tag = index + 1000
            amount.textAlignment =  .center
            amount.font = UIFont.systemFont(ofSize: 10)
            addSubview(tree)
            backgroundColor = UIColor.clear
            addSubview(amount)
            
        }
        
    }
    func reloadData(dic : [String : AnyObject]) {
        //        initUI()
        //来修改设置frame
        for index in 0...5{
            let float : CGFloat = CGFloat.init(index)
            let oringnWith = ((UIScreen.main.bounds.size.width - 5*30)/6.0) * float + 30 * float - 30
            
            let tag : Int = index + 100
            
            let amounttag : Int = index + 1000
            
            let tree : UILabel = self.viewWithTag(tag) as! UILabel
            
            let amount : UILabel = self.viewWithTag(amounttag) as! UILabel
            
//            if index == 2 {
                tree.frame =   CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0 - 10*float-30-10, width: 30, height:  10*float+30)
                amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: self.frame.size.height/2.0  - 10 * float - 20 - 30  , width:   40, height: 20)
                amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: tree.frame.origin.y - 20, width:   40, height: 20)
//            }else
            
//            {
            
//                tree.frame =   CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0-10 , width: 30, height:  10*float+20)
//                
//                amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: tree.frame.origin.y + tree.frame.size.height , width:   40, height: 20)
//            }
            
//            amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: self.frame.size.height/2.0  - 10 * float - 20 - 30  , width:   40, height: 20)
              amount.text = "56.7%"
        }
        
    }
    
    
    
    
}
