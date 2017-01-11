//
//  KLineView.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
class KLineView: UIView {
    @IBOutlet weak var miuCharts: LineChartView!
    @IBOutlet weak var min15Charts: CombinedChartView!
    @IBOutlet weak var hourCharts: CombinedChartView!
    @IBOutlet weak var dayCharts: CombinedChartView!
    var dayEntrys: [CandleChartDataEntry] = []
    
    var selectIndex: NSInteger!{
        didSet{
            switch selectIndex {
            case 1:
                bringSubview(toFront: self.miuCharts)
                break
            case 2:
                bringSubview(toFront: self.min15Charts)
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
    
    enum KType: Int {
        case miu = 1   //1分钟
        case miu5 = 2  //5分钟
        case miu15 = 3 //15分钟
        case miu30 = 4 //30分钟
        case miu60 = 5 //60分钟
        case day = 6   //日K线
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectIndex = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initMiuChartView()
        initLineChartData()
        initDayKChartData()
    }

    //MARK: --miuCharts
    func initMiuChartView() {
        
        for charts in self.subviews {
            if charts.isKind(of:BarLineChartViewBase.self) {
                let chartsView = charts as! BarLineChartViewBase
                chartsView.legend.setCustom(entries: [])
                chartsView.noDataText = "暂无数据"
                chartsView.xAxis.labelPosition = .bottom
                chartsView.xAxis.drawGridLinesEnabled = false
                chartsView.xAxis.axisMinimum = 0
                chartsView.leftAxis.labelFont = UIFont.systemFont(ofSize: 0)
                chartsView.leftAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
                chartsView.rightAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
                
            }
        }
        
        dayCharts.xAxis.axisMaximum = 30
        
        
        
    }
    
    func initLineChartData() {
        let lineCount = [7.0,6.0,7.0,8.0,9.0,5.0,6.0,7.0,8.0,9.0]
        let L = [1.0,2.0,3.0,4.0,5.0,4.0,3.0,2.0,1.0,1.0]
        let O = [3.0,4.0,5.0,6.0,7.0,6.0,5.0,4.0,3.0,2.0]
        
        var entrys: [ChartDataEntry] = []
        var entrys1: [ChartDataEntry] = []
        var entrys2: [ChartDataEntry] = []
        for i in 0...lineCount.count - 1  {
            let entry = ChartDataEntry.init(x: Double(i), y: lineCount[i])
            entrys.append(entry)
            
            let entry1 = ChartDataEntry.init(x: Double(i), y: L[i])
            entrys1.append(entry1)
            
            let entry2 = ChartDataEntry.init(x: Double(i), y: O[i])
            entrys2.append(entry2)
            
        }
        
        let set: LineChartDataSet = LineChartDataSet.init(values: entrys, label: "折线图")
        set.mode = .stepped
        set.colors = [UIColor.blue]
        
        let set1: LineChartDataSet = LineChartDataSet.init(values: entrys1, label: "折线图1")
        set1.mode = .cubicBezier
        set1.colors = [UIColor.red]
        
        let set2: LineChartDataSet = LineChartDataSet.init(values: entrys2, label: "折线图2")
        set2.mode = .horizontalBezier
        set2.colors = [UIColor.green]
        
        let data: LineChartData  = LineChartData.init(dataSets: [set,set1,set2])
        miuCharts.data = data
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.lineData = data
        
        
    }
    //MARK: --日K线
    func initDayCandleStickData() {
        
        let set: CandleChartDataSet = CandleChartDataSet.init(values: dayEntrys, label: nil)
        set.increasingColor = UIColor.init(rgbHex: 0xE9573f)
        set.decreasingColor = UIColor.init(rgbHex: 0x009944)
        set.increasingFilled = true
        set.shadowColorSameAsCandle = true
        set.formLineWidth = 5
        let dataSets: [IChartDataSet] = [set]
        let data: CandleChartData = CandleChartData.init(dataSets: dataSets)
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.candleData = data
        dayCharts.data = combinData
    }
    
    func initDayKChartData(){
        let param = KChartParam()
        if let model: ProductModel = DealModel.share().selectProduct{
            param.id = UserModel.currentUserId
            param.token = UserModel.token!
            param.goodType = model.typeCode
            param.exchange_name = model.exchange_name
            param.platform_name = model.platform_name
            param.chartType = KType.day.rawValue
        }
        AppAPIHelper.deal().kChartsData(param: param, complete: { [weak self](result) -> ()? in
            if let models: [KChartModel] = result as? [KChartModel]{
                for index in 0...models.count-1{
                    let model = models[index%models.count]
                    let location = Double(index+1)
                    let entry = self?.convertModelToCandleDataEntry(model: model, location:location)
                    self?.dayEntrys.append(entry!)
                    self?.initDayCandleStickData()
                }
            }
            return nil
        }, error: nil)
    }
    
    func convertModelToCandleDataEntry(model: KChartModel, location:Double) -> CandleChartDataEntry {
        
        let entry = CandleChartDataEntry.init(x:location, shadowH: model.highPrice, shadowL: model.lowPrice, open: model.openPrice, close: model.closePrice)
        
        return entry
    }
    
}
