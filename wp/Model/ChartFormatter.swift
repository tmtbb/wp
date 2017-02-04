//
//  ChartFormatter.swift
//  wp
//
//  Created by 木柳 on 2016/12/30.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
class ChartFormatter: NSObject, IAxisValueFormatter {
    fileprivate var values: [String]?
    public init(values: [String]){
        super.init()
        self.values = values
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return values![index]
    }
}
