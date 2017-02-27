//
//  FriendVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
import DKNightVersion

class FriendVC: BaseTableViewController {
    
    
    //设置头像的宽度
    @IBOutlet weak var headWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var headerImage: UIImageView!             //用户头像
    @IBOutlet weak var bgImage: UILabel!                 //背景图片
    @IBOutlet weak var wainningText: UITextField!            //消息内容
    
    @IBOutlet weak var totalBenifityBtn: UIButton!           //总收益Btn
    @IBOutlet weak var totalBenifityLabel: UILabel!          //总收益Lb
    @IBOutlet weak var monthBenifityLabel: UILabel!          //本月收益Lb
    @IBOutlet weak var weekBenifityLabel: UILabel!          //周收益Lb
    //    @IBOutlet weak var benifityBarChart: BarChartView!      //表格视图
    
    @IBOutlet weak var shareCountLabel: UILabel!            //好友晒单
    @IBOutlet weak var monthShareLabel: UILabel!            //本月分享晒单数目
    @IBOutlet weak var weekShareLabel: UILabel!             //周分享晒单数目
    @IBOutlet weak var dayShareLabel: UILabel!              //本天分享晒单数目
    @IBOutlet weak var focusOn: UIButton!
    private var index: NSInteger = 0                        //判断点击的数目刷新区的row的行数
    private var lastTypeBtn: UIButton?                      //判断点击的btn
    @IBOutlet weak var cancelFocus: UIButton!               //取消按钮
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        title = "张飞"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    //MARK: --DATA
    func initData() {
        cancelFocus.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60)
        cancelFocus.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        cancelFocus.setImage(UIImage.init(named: "addFocusOn"), for: .normal)
        cancelFocus.setTitle("关注", for: .normal)
        itemBtnTapped(totalBenifityBtn)
    }
    //MARK: --UI
    func initUI() {
        
        headWidth.constant = 100 * (UIScreen.main.bounds.size.width)/320.0
        tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        initBenifityBarChartUI()
        initBenifityBarChartData()
        
       bgImage.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
    }
    //MARK: --最近5单交易
    func initBenifityBarChartUI() {
        //        benifityBarChart.legend.setCustom(entries: [])
        //        benifityBarChart.noDataText = "暂无数据"
        //        //x轴
        //        benifityBarChart.xAxis.labelPosition = .bottom
        //        benifityBarChart.xAxis.gridColor = UIColor.clear
        //        //        benifityBarChart.
        //        //y轴
        //        benifityBarChart.leftAxis.gridColor = UIColor.clear
        //        benifityBarChart.rightAxis.gridColor = UIColor.clear
        
        
    }
    // 刷新列表页数据
    func initBenifityBarChartData() {
        let values = [20.0, -4.0, -6.0, -25.0, 13.0]
        
        //        let times: [String] = ["10:00","11:00","12:00","13:00","14:00"]
        //        let formatter: ChartFormatter = ChartFormatter.init(values: times)
        //        var barEntrys: [BarChartDataEntry] = []
        //        let xaxis: XAxis = XAxis.init()
        //
        //         let yaxis: YAxis = YAxis.init()
        //            yaxis.inverted = false;
        //        for (index, value) in values.enumerated() {
        //            let barEntry: BarChartDataEntry = BarChartDataEntry.init(x: Double(index), yValues: [value], label: "title\(index)")
        //            barEntrys.append(barEntry)
        //            formatter.stringForValue(Double(index), axis: xaxis )
        //        }
        //         benifityBarChart.xAxis.labelPosition = .bottom
        //        benifityBarChart.legend.enabled = false
        ////        benifityBarChart
        ////        xaxis.labelPosition =  .leftBottom
        //
        
        //        benifityBarChart.descriptionText = ""
        //        xaxis.valueFormatter = formatter
        //        xaxis.spaceMax = 19;
        //        benifityBarChart.xAxis.granularityEnabled = true
        //        benifityBarChart.xAxis.granularity = 1.0
        //        benifityBarChart.xAxis.decimals = 0
        //        benifityBarChart.leftAxis.enabled = false
        //        benifityBarChart.rightAxis.enabled = false
        //        benifityBarChart.xAxis.valueFormatter = xaxis.valueFormatter
        //        let set: BarChartDataSet = BarChartDataSet.init(values: barEntrys, label: nil)
        //
        //
        //
        //
        //
        //        set.colors = [UIColor.red,UIColor.blue,UIColor.purple]
        //        let dataSets: [IChartDataSet] = [set]
        //        let data: BarChartData = BarChartData(dataSets: dataSets)
        //        benifityBarChart.data = data
    }
    
    //MARK: --总收益/好友晒单/好友推单
    @IBAction func itemBtnTapped(_ sender: UIButton) {
        if let btn = lastTypeBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
        }
        sender.isSelected = true
        sender.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: "main")
        lastTypeBtn = sender
        index = sender.tag
        tableView.reloadData()
    }
    //MARK: --推单通知
    @IBAction func recommendBtnTapped(_ sender: Any) {
        
        
        
        //button标题的偏移量，这个偏移量是相对于图片的
       
        if checkLogin(){
            cancelFocus.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            cancelFocus.setImage(UIImage.init(named: "addFocusOn"), for: .normal)
            //     cancelFocus.setTitle("关注", for: .normal)
            if cancelFocus.titleLabel?.text == "取消关注" {
                cancelFocus.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60)
                cancelFocus.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
                cancelFocus.setImage(UIImage.init(named: "addFocusOn"), for: .normal)
                cancelFocus.setTitle("关注", for: .normal)
            }
            else {
                cancelFocus.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 60)
                cancelFocus.setTitle("取消关注", for: .normal)
                cancelFocus.titleEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0)
                cancelFocus.setImage(UIImage.init(named: "cancelFocusOn"), for: .normal)
            }
            
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let story : UIStoryboard = UIStoryboard.init(name: "Share", bundle: nil)
        //
        //        let wealth  = story.instantiateViewController(withIdentifier: "MyWealtVC")
        //
        //        navigationController?.pushViewController(wealth, animated: true)
    }
    
    //MARK: --Tableview's delegate and datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == index{
            
            return section == 2 ? 6:2
            
        }else{
            return 0
        }
    }
}
