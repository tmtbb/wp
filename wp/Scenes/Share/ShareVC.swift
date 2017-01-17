//
//  ShareVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
protocol VistorLoginViewDelegate:NSObjectProtocol {
    //设置协议方法
    func visitorViewRegisterViewSelected()
}


class ShareVC: BaseTableViewController ,ShareCellDelegate {
    internal func cellBtnTapped(string: String) {
        
        
    }

    
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var weekBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    private var lastTypeBtn: UIButton?
    
    private var lastTypeImg: UIImageView?
    // 月份图片
    @IBOutlet weak var monthImg: UIImageView!
    @IBOutlet weak var shareTableView: ShareFriendTableView!
    
    @IBOutlet weak var lastDayImg: UIImageView!
    @IBOutlet weak var weekImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    //MARK: --DATA
    func initData() {
        lastTypeBtn = dayBtn
        dayBtn.alpha = 1
        weekBtn.alpha = 0.5
        monthBtn.alpha = 0.5
        lastTypeImg = lastDayImg
        lastDayImg.isHidden = false
        weekImg.isHidden = true
        monthImg.isHidden = true
        shareTableView.cellDelegate = self
        //        dayBtn.isSelected = false
        
        
    }
    //MARK: --网络请求方法
    override func didRequest() {
        //        didRequestComplete(nil)
        
        //注释掉  请求接口有的时候再打开
        //        AppAPIHelper.share().getShareData(userId: "123", phone: "15306559323", selectIndex: "1223", pageNumber: "0", complete: { (result ) -> ()? in
        //
        //            return nil
        //        }, error: errorBlockFunc())
        //        print(errorBlockFunc)
        
    }
    
    
    //MARK: --UI
    func initUI() {
        
        tableView.rowHeight = 66
        //        rankTypeBtnTapped(dayBtn)
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
    }
    //MARK: --昨天之星，上周名人，月度名人
    
    @IBAction func rankTypeBtnTapped(_ sender: UIButton) {
        
        
        if let btn = lastTypeBtn {
            btn.isSelected = false
            
            btn.setTitleColor(UIColor.init(hexString: "FFFFFF"), for: UIControlState.normal)
            btn.alpha = 0.5
            lastDayImg.isHidden = true
            weekImg.isHidden  = true
            monthImg.isHidden = true
        }
        
        sender.setTitleColor(UIColor.init(hexString: " FFFFFF"), for: UIControlState.normal)
        sender.isSelected = true
        sender.alpha = 1
        if sender == monthBtn {
            monthImg.isHidden = false
           
        }
        if sender == weekBtn {
            weekImg.isHidden = false
            
        }
        if sender ==  dayBtn {

            lastDayImg.isHidden = false
        }
        lastTypeBtn = sender
    }
    
    
    func selectDate(){
        
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height - 44 - 107
    }
    
    
}
