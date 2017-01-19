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
        
        
        //        self.addSubview(view)
        
        initUI()
    }
    
    //MARK-设置UI数据
    func initUI(){
        
        //中间分割线
        let  line : UILabel = UILabel.init(frame: CGRect.init(x: 17, y: self.frame.size.height/2, width: UIScreen.main.bounds.size.width - 34, height: 0.5))
        
        self.addSubview(line)
        
        line.backgroundColor = UIColor.init(hexString: "333333")
        
        
        // 向下不用减 向上 需要减 lab的高度  70 为最高 所以每个高度为 70*百分比
        
        for index in 0...5{
            
            let float : CGFloat = CGFloat.init(index)
            let oringnWith = ((UIScreen.main.bounds.size.width - 5*30)/6.0) * float + 30 * float - 30
            //设置画柱状图
            let tree = UILabel.init()
            
            let amount = UILabel.init()
            tree.frame =   CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0 - 10*float-20, width: 30, height:  10*float+20)
//            if index == 2 {
//                tree.frame =   CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0 - 10*float-20, width: 30, height:  10*float+20)
//            }else{
//                
//                tree.frame = CGRect.init(x: oringnWith  , y: self.frame.size.height/2.0 , width: 30, height:  10*float+20)
//            }
            
            
            // 涨率
            tree.backgroundColor = UIColor.init(hexString: "E9573E")            
            amount.frame = CGRect.init(x: tree.frame.origin.x - 5 , y: self.frame.size.height/2.0  - 10 * float - 20 - 50  , width:   40, height: 20)
            
//            amount.text = "1222"
            amount.textAlignment =  .center
            amount.font = UIFont.systemFont(ofSize: 10)
            self.addSubview(tree)
            self.backgroundColor = UIColor.clear
            self.addSubview(amount)
            
        }
        
    }
    func dataDic(dic : [String : AnyObject]) {
        
    }
    
    
    
    
}
