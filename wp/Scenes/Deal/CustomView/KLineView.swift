//
//  KLineView.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
import SVProgressHUD
class KLineView: UIView {
    @IBOutlet weak var miuCharts: LineChartView!
    @IBOutlet weak var miu15Charts: CombinedChartView!
    @IBOutlet weak var hourCharts: CombinedChartView!
    @IBOutlet weak var dayCharts: CombinedChartView!
    var miu15Models: [KChartModel] = []
    var miu60Models: [KChartModel] = []
    var dayModels: [KChartModel] = []
    
    var selectIndex: NSInteger!{
        didSet{
            switch selectIndex {
            case 1:
                bringSubview(toFront: self.miuCharts)
                break
            case 2:
                initMiu15KChartsData()
                bringSubview(toFront: self.miu15Charts)
                break
            case 3:
                bringSubview(toFront: self.hourCharts)
                break
            case 4:
                bringSubview(toFront: self.dayCharts)
                break
            default:
                bringSubview(toFront: self.miuCharts)
            }
        }
    }
    
 
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectIndex = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initChartView()
        refreshKLine()
        //每隔60秒刷新一次分时数据
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(initMiuLChartsData), userInfo: nil, repeats: true)
        //每隔15分钟刷新一次分时数据
        Timer.scheduledTimer(timeInterval: 15*60, target: self, selector: #selector(initMiu15KChartsData), userInfo: nil, repeats: true)
        //每隔60分钟刷新一次分时数据
        Timer.scheduledTimer(timeInterval: 60*60, target: self, selector: #selector(initMiu60KChartsData), userInfo: nil, repeats: true)
    }

    //MARK: --Charts
    func initChartView() {
        for charts in self.subviews {
            if charts.isKind(of:BarLineChartViewBase.self) {
                let chartsView = charts as! BarLineChartViewBase
                chartsView.legend.setCustom(entries: [])
                chartsView.noDataText = "暂无数据"
                chartsView.xAxis.labelPosition = .bottom
                chartsView.xAxis.drawGridLinesEnabled = false
                chartsView.xAxis.axisMinimum = 0
                chartsView.xAxis.labelFont = UIFont.systemFont(ofSize: 0)
                chartsView.leftAxis.labelFont = UIFont.systemFont(ofSize: 0)
                chartsView.leftAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
                chartsView.rightAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
                chartsView.zoom(scaleX: 2.0, scaleY: 0, x: 0, y: 0)
            }
        }
    }
    func refreshKLine() {
        initMiuLChartsData()
        initMiu15KChartsData()
        initMiu60KChartsData()
    }
    //MARK: --分时图
    func initMiuLChartsData() {
        let type = DealModel.share().selectProduct == nil ? "" : DealModel.share().selectProduct?.symbol
        let fromTime: Int = Int(Date.startTimestemp())
        let toTime: Int = Int(Date.nowTimestemp())
        KLineModel.queryTimelineModels(fromTime: fromTime, toTime: toTime, goodType: type!){[weak self](result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel] {
                self?.refreshLineChartData(models: models)
            }
            return nil
        }
    }
    //MARK: --15分钟
    func initMiu15KChartsData() {
        let type = DealModel.share().selectProduct == nil ? "" : DealModel.share().selectProduct?.symbol
        let fromTime: Int = Int(Date.startTimestemp())
        let toTime: Int = Int(Date.nowTimestemp())
        KLineModel.query15KLineModels(fromTime: fromTime, toTime: toTime, goodType: type!){[weak self](result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel] {
                self?.refreshCandleStickData(type: .miu15, models: models)
            }
            return nil
        }
    }
    //MARK: --60分钟
    func initMiu60KChartsData() {
        let type = DealModel.share().selectProduct == nil ? "" : DealModel.share().selectProduct?.symbol
//        KLineModel.queryModels(type: .miu60, goodType: type!) { [weak self](result) -> ()? in
//            if let model: KChartModel = result as? KChartModel{
//                self?.miu60Models.append(model)
//                self?.refreshCandleStickData(type: .miu15, models: (self?.miu15Models)!)
//            }
//            return nil
//        }
    }
    //MARK: --日K线
    func initDayKChartsData() {
        
        
    }
    //刷新折线
    func refreshLineChartData(models: [KChartModel]) {
        let max = models.count + 100
        if models.count == 0 {
            miuCharts.clearValues()
            return
        }

        var entrys: [ChartDataEntry] = []
        for (i, model) in models.enumerated()  {
            let _ = autoreleasepool(invoking: {
                let entry = ChartDataEntry.init(x: Double(i), y: model.currentPrice)
                entrys.append(entry)
            })
        }
        let set: LineChartDataSet = LineChartDataSet.init(values: entrys, label: "折线图")
        set.colors = [UIColor.init(rgbHex: 0x666666)]
        set.circleRadius = 0
        set.circleHoleRadius = 0
        set.mode = .cubicBezier
        set.valueFont = UIFont.systemFont(ofSize: 0)
        set.drawFilledEnabled = true
        set.fillColor = UIColor.init(rgbHex: 0x999999)
        let data: LineChartData  = LineChartData.init(dataSets: [set])
        miuCharts.data = data
        miuCharts.xAxis.axisMaximum = Double(max)
    }
    //刷新K线
    func refreshCandleStickData(type: KLineModel.KLineType, models: [KChartModel]) {
        if models.count == 0 {
            switch type {
            case .day:
                dayCharts.clearValues()
                break
            case .miu60:
                hourCharts.clearValues()
                break
            case .miu15:
                miu15Charts.clearValues()
                break
            default:
                return
            }
            return
        }
        var entrys: [ChartDataEntry] = []
        for (index, model) in models.enumerated(){
            let _ = autoreleasepool(invoking: {
                let location = Double(index+1)
                let entry = convertModelToCandleDataEntry(model: model, location:location)
                entrys.append(entry)
                let _ = autoreleasepool(invoking: {
                    model
                })
            })
        }
        let set: CandleChartDataSet = CandleChartDataSet.init(values: entrys, label: nil)
        set.increasingColor = UIColor.init(rgbHex: 0xE9573f)
        set.decreasingColor = UIColor.init(rgbHex: 0x009944)
        set.increasingFilled = true
        set.shadowColorSameAsCandle = true
        set.formLineWidth = 5
        set.valueFont = UIFont.systemFont(ofSize: 0)
        let dataSets: [IChartDataSet] = [set]
        let data: CandleChartData = CandleChartData.init(dataSets: dataSets)
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.candleData = data
        
        switch type {
        case .day:
            dayCharts.data = combinData
            break
        case .miu60:
            hourCharts.data = combinData
            break
        case .miu15:
            miu15Charts.data = combinData
            break
        default:
            return
        }
    }
    
    func convertModelToCandleDataEntry(model: KChartModel, location:Double) -> CandleChartDataEntry {
        let entry = CandleChartDataEntry.init(x:location, shadowH: model.highPrice, shadowL: model.lowPrice, open: model.openPrice, close: model.closePrice)
        return entry
    }
    
    func convertModelToLineDataEntry(model: KChartModel, location:Double) -> ChartDataEntry {
        let entry = ChartDataEntry.init(x: location, y: model.currentPrice)
        return entry
    }
}
