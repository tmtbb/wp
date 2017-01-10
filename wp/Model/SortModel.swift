//
//  SortModel.swift
//  wp
//
//  Created by sum on 2017/1/5.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
//排行Model
class SortModel: BaseModel {
  
    //返回数据的model 
    var listItem  :  [ListSortModel]!
    
    //排名 
      var sort  :  String?
   
    
}

class ListSortModel: BaseModel {
    
     var name  :   String?               //姓名
     var type  :   String?               //类别
     var time  :   String?               //时间
     var benifity  :  String?            //收益
     var userHeaderImg  :  String?       //头像
     var iconImg  :  String?             //姓名
     var status  :   String?             //状态
}
