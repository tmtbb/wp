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
class KLineView: UIView, ChartViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var miuCharts: LineChartView!
    @IBOutlet weak var klineCharts: CombinedChartView!
    private var currentCharts: BarLineChartViewBase?
    private var currentModels: [KChartModel] = []
    private var currentType: String = ""
    private var currentKlineType: KLineModel.KLineType = .miu
    var selectModelBlock: CompleteBlock?
    
    var selectIndex: NSInteger!{
        didSet{
            currentCharts?.zoom(scaleX: 0, scaleY: 0, x: 0, y: 0)
            switch selectIndex {
            case 0:
                currentCharts = self.miuCharts
                bringSubview(toFront: self.miuCharts)
                break
            default:
                currentCharts = self.klineCharts
                bringSubview(toFront: self.klineCharts)
            }
            refreshKLine()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectIndex = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initChartView()
        selectIndex = 0
        refreshKLine()
        //每隔60秒刷新一次分时数据
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(refreshKLine), userInfo: nil, repeats: true)
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
                chartsView.delegate = self
                chartsView.chartDescription?.text = ""
                chartsView.xAxis.axisMaximum = AppConst.klineCount+1
                chartsView.animate(xAxisDuration: 1)
            }
        }
        klineCharts.animate(yAxisDuration: 1)
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = chartView == miuCharts ? Int(entry.x) : Int(entry.x-1)
        if index >= 0 && index < currentModels.count {
            if let model: KChartModel = currentModels[index]{
                if selectModelBlock != nil{
                    selectModelBlock!(model)
                }
            }
        }
    }
    
    //MARK: --刷新K线
    func refreshKLine() {
        switch selectIndex {
        case 0:
            initMiuLChartsData()
            break
        case 1:
            initKChartsData(type: .miu5)
            break
        case 2:
            initKChartsData(type: .miu15)
            break
        case 3:
            initKChartsData(type: .miu30)
            break
        case 4:
            initKChartsData(type: .miu60)
            break
        default:
            break
        }
    }
    
    //MARK: --读取分时数据
    func initMiuLChartsData() {
        if DealModel.share().selectProduct == nil{
            return
        }
        let type =  DealModel.share().selectProduct!.symbol
        let toTime: Int = Int(Date.nowTimestemp())
        let fromTime: Int = toTime - 60*Int(AppConst.klineCount)
        KLineModel.queryTimelineModels(fromTime: fromTime, toTime: toTime, goodType: type){[weak self](result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel] {
               self?.refreshLineChartData(models: models)
                self?.currentModels = models
            }
            return nil
        }
    }
    //刷新折线
    func refreshLineChartData(models: [KChartModel]) {
        
        if models.count == 0 {
            miuCharts.clearValues()
            return
        }
        var entrys: [ChartDataEntry] = []
        for (i, model) in models.enumerated()  {
            currentType = model.symbol
            let entry = ChartDataEntry.init(x: Double(i), y: model.currentPrice)
            entrys.append(entry)
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
        miuCharts.data?.notifyDataChanged()
        miuCharts.setNeedsDisplay()
    }
    //MARK: --读取K线数据
    func initKChartsData(type: KLineModel.KLineType) {
        if DealModel.share().selectProduct == nil {
            return
        }
        let goodType = DealModel.share().selectProduct!.symbol
        let toTime: Int = Int(Date.nowTimestemp())
        let fromTime: Int = toTime - Int(type.rawValue)*Int(AppConst.klineCount)
        KLineModel.queryKLineModels(type: type, fromTime: fromTime, toTime: toTime, goodType: goodType){[weak self](result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel] {
                self?.refreshCandleStickData(type: type, models: models)
                self?.currentModels = models
            }
            return nil
        }
    }
    //刷新K线
    func refreshCandleStickData(type: KLineModel.KLineType, models: [KChartModel]) {
        if models.count == 0 {
            klineCharts.clearValues()
            return
        }
        var entrys: [ChartDataEntry] = []
        for (index, model) in models.enumerated(){
            currentType = model.symbol
            let location = Double(index+1)
            let entry = CandleChartDataEntry.init(x:location, shadowH: model.highPrice, shadowL: model.lowPrice, open: model.openingTodayPrice, close: model.closedYesterdayPrice)
            entrys.append(entry)
        }
        let set: CandleChartDataSet = CandleChartDataSet.init(values: entrys, label: nil)
        set.increasingColor = UIColor.init(rgbHex: 0xE9573f)
        set.decreasingColor = UIColor.init(rgbHex: 0x009944)
        set.neutralColor = UIColor.init(rgbHex: 0x009944)
        set.increasingFilled = true
        set.shadowColorSameAsCandle = true
        set.formLineWidth = 5
        set.valueFont = UIFont.systemFont(ofSize: 0)
        let dataSets: [IChartDataSet] = [set]
        let data: CandleChartData = CandleChartData.init(dataSets: dataSets)
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.candleData = data
        
        klineCharts.data = combinData
        klineCharts.data?.notifyDataChanged()
        
    }
}
