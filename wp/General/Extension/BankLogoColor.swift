//
//  BankLogoColor.swift
//  wp
//
//  Created by sum on 2017/2/16.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class BankLogoColor: NSObject {

    private static var model: BankLogoColor = BankLogoColor()
    var banklogo = NSDictionary()
    class func share() -> BankLogoColor{
        
          let diaryList:String = Bundle.main.path(forResource: "BankList", ofType:"plist")!
        
          let data : NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
      
          model.banklogo = data
        
        return model
    }
    //  读取颜色
    func readfilefromlocal(string : String) -> UIColor {
        
        if string == "" {
            return UIColor.init(hexString: "98D8D")
        }
        if banklogo[string] != nil {
            
             let str : String =  banklogo[string] as! String
             return UIColor.init(hexString: str)
        }
        _ = ["1":"2","3":"4"]
       
        return UIColor.init(hexString: "1D6AAF")
        
       
    
       
    }
     //  判断是否是本地的五大银行
    
    func checkLocalBank(string : String) -> Bool {
        
        if banklogo[string] != nil{
        
            return true
        }else{
        
            return false
        }
    }
}
