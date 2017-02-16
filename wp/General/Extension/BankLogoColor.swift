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
    func readfilefromlocal(string : String) -> UIColor {
        
        let str : String =  banklogo[string] as! String
    
        return UIColor.init(hexString: str)
        
    }
}
