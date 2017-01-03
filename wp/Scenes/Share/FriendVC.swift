//
//  FriendVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts


class FriendVC: BaseTableViewController {
    //头部
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var wainningText: UITextField!
    //总收益
    @IBOutlet weak var totalBenifityBtn: UIButton!
    @IBOutlet weak var totalBenifityLabel: UILabel!
    @IBOutlet weak var monthBenifityLabel: UILabel!
    @IBOutlet weak var weekBenifityLabel: UILabel!
    @IBOutlet weak var benifityBarChart: BarChartView!
    //好友晒单
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var monthShareLabel: UILabel!
    @IBOutlet weak var weekShareLabel: UILabel!
    @IBOutlet weak var dayShareLabel: UILabel!
    private var index: NSInteger = 0
    private var lastTypeBtn: UIButton?
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translucent(clear: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        translucent(clear: false)
    }
    //MARK: --DATA
    func initData() {
        itemBtnTapped(totalBenifityBtn)
    }
    //MARK: --UI
    func initUI() {
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        initBenifityBarChartUI()
        initBenifityBarChartData()
    }
    //MARK: --最近5单交易
    func initBenifityBarChartUI() {
        benifityBarChart.legend.setCustom(entries: [])
        benifityBarChart.noDataText = "暂无数据"
        //x轴
        benifityBarChart.xAxis.labelPosition = .bottom
        benifityBarChart.xAxis.gridColor = UIColor.clear
//        benifityBarChart.
        //y轴
        benifityBarChart.leftAxis.gridColor = UIColor.clear
        benifityBarChart.rightAxis.gridColor = UIColor.clear
        
        
    }

    func initBenifityBarChartData() {
        let values = [20.0, 4.0, 6.0, 25.0, 13.0]
        
        let times: [String] = ["10:00","11:00","12:00","13:00","14:00"]
        let formatter: ChartFormatter = ChartFormatter.init(values: times)
        var barEntrys: [BarChartDataEntry] = []
        let xaxis: XAxis = XAxis.init()
        for (index, value) in values.enumerated() {
            let barEntry: BarChartDataEntry = BarChartDataEntry.init(x: Double(index), yValues: [value], label: "title\(index)")
            barEntrys.append(barEntry)
            formatter.stringForValue(Double(index), axis: xaxis)
        }
        xaxis.valueFormatter = formatter
        benifityBarChart.xAxis.valueFormatter = xaxis.valueFormatter
        let set: BarChartDataSet = BarChartDataSet.init(values: barEntrys, label: nil)
        set.colors = [UIColor.red,UIColor.blue,UIColor.purple]
        let dataSets: [IChartDataSet] = [set]
        let data: BarChartData = BarChartData(dataSets: dataSets)
        benifityBarChart.data = data
    }

    //MARK: --总收益/好友晒单/好友推单
    @IBAction func itemBtnTapped(_ sender: UIButton) {
        if let btn = lastTypeBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
        }
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
        lastTypeBtn = sender
        index = sender.tag
        tableView.reloadData()
    }
    //MARK: --推单通知
    @IBAction func recommendBtnTapped(_ sender: Any) {
        if checkLogin(){
            
        }
    }
    //MARK: --Tableview's delegate and datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == index{
            return section == 2 ? 3:2
        }else{
            return 0
        }
    }
}
