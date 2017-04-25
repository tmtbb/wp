//
//  DealApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol DealApi{
    //当前仓位列表
    func currentDeals(complete: CompleteBlock?, error:ErrorBlock?)
    //历史仓位列表
    func historyDeals(param: UndealParam, complete: CompleteBlock?, error:ErrorBlock?)
    //建仓
    func buildDeal(model: DealParam, complete: CompleteBlock?, error: ErrorBlock?)
    //商品列表
    func products(param: ProductParam, complete: CompleteBlock?, error:ErrorBlock?)
    //当时K线数据
    func kChartsData(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?)
    //当时分时数据
    func timeline(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?)
    //当前报价
    func realtime(param: [String: Any], complete: CompleteBlock?, error:ErrorBlock?)
    //仓位信息
    func position(param: PositionParam, complete: CompleteBlock?, error:ErrorBlock?)
    //收益选择
    func benifity(param: BenifityParam, complete: CompleteBlock?, error:ErrorBlock?)
    //明细列表
    func requestDealDetailList(pram:DealHistoryDetailParam, complete: CompleteBlock?, error:ErrorBlock?)
    
}

