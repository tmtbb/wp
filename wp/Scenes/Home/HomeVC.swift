//
//  HomeVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class HomeVC: BaseTableViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableHeaderView = setupHeaderView()
    }
    
      func setupHeaderView () -> (UIView) {
        let sunView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 170))
        let images: [String] = ["1", "1", "1"]
        //创建无限轮播
        let cycleView = CSCycleView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 135), images: images, titles: [])
        cycleView.delegate = self;
        sunView.addSubview(cycleView)
        
        let hornImage = UIImageView(image: UIImage(named: "horn"))
        sunView.addSubview(hornImage)
        hornImage.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(9)
            make.left.equalTo(sunView).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(17)
        }
        
        let informLabel = UILabel()
        informLabel.text = "特别通知"
        informLabel.font = UIFont.systemFont(ofSize: 12)
        informLabel.textColor = UIColor(rgbHex: 0x666666)
        sunView.addSubview(informLabel)
        
        informLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(11)
            make.left.equalTo(hornImage.snp.right).offset(10)
        }
        
        let contentSourceArray: [String] = ["这是一条重大新闻","吃货节到了钱包准备好了吗","独家福利来就送!"]
        
        let singlerView = CSSinglerowView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30), scrollStyle: .up, roundTime: 2, contentSource: contentSourceArray, tagSource: [] )
        singlerView.backColor = UIColor.clear
        
        singlerView.delegate = self
        sunView .addSubview(singlerView)
        
        singlerView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(2)
            make.left.equalTo(informLabel.snp.right).offset(27)
            
        }
        return sunView
    }
    
    //MARK: --DATA
    func initData() {
    }
    //MARK: --UI
    func initUI() {
//        contentView.backgroundColor = UIColor(rgbHex: 0xe9573f)
        
        navigationController?.addSideMenuButton()
        self.title = "首页"
        let homeStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        let loginNav:BaseNavigationController = homeStoryboard.instantiateViewController(withIdentifier: "LoginNav") as! BaseNavigationController
        present(loginNav, animated: true, completion: nil)
        
    }
    //MARK: --UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        if section == 1 {
            
            return 5
        }
      return 6
    }
    
//    func registerNotify() {
//        let notificationCenter = NotificationCenter.default
//        
//        notificationCenter.addObserver(self, selector: #selector(jumpToMyMessageController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyMessage), object: nil)
//        
//        notificationCenter.addObserver(self, selector: #selector(jumpToMyAttentionController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyAttention), object: nil)
//        notificationCenter.addObserver(self, selector: #selector(jumpToMyPushController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyPush), object: nil)
//        notificationCenter.addObserver(self, selector: #selector(jumpToMyBaskController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToMyBask), object: nil)
//        nnotificationCenter.addObserver(self, selector: #selector(jumpToDealController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToDeal), object: nil)
//        notificationCenter.addObserver(self, selector: #selector(jumpToFeedbackController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToFeedback), object: nil)
//        notificationCenter.addObserver(self, selector: #selector(jumpToProductGradeController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToProductGrade), object: nil)
//        notificationCenter.addObserver(self, selector: #selector(jumpToAttentionUsController), name: NSNotification.Name(rawValue: AppConst.NotifyDefine.jumpToAttentionUs), object: nil)
//    }
//    
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyAttentionController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
//    func jumpToMyMessageController() {
//        
//        let myMessageVC = MyMessageController()
//        navigationController?.pushViewController(myMessageVC, animated: true)
//    }
    
 
}

extension HomeVC:CSCycleViewDelegate,CSSinglerViewDelegate {
    //MARK: -- CSCycleViewDelegate
    func  clickedCycleView(_ cycleView : CSCycleView, selectedIndex index: Int) {
        
        print("点击了第\(index)页")
    }
    
    
    //MARK: -- CSSinglerViewDelegate
    
    func singlerView(_ singlerowView: CSSinglerowView, selectedIndex index: Int) {
        
        print("点击了第\(index)个数据")
        
    }
}

