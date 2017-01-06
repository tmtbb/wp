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
    var listItem  :  [ListSortModel]?
    
    //排名 
    dynamic var sort  :  String?
   
    
}

class ListSortModel: BaseModel {
    
   dynamic var name  :   String?               //姓名
   dynamic var type  :   String?               //类别
   dynamic var time  :   String?               //时间
   dynamic var benifity  :  String?            //收益
   dynamic var userHeaderImg  :  String?       //头像
   dynamic var iconImg  :  String?             //姓名
   dynamic var status  :   String?             //状态
}
