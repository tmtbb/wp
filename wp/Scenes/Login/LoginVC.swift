//
//  LoginVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class LoginVC: BaseTableViewController {
    
    var loginComplete: CompleteBlock?
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: --DATA
    func initData() {
        NotificationCenter.default.addObserver(self, selector: #selector(errorCode(_:)), name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: nil)
    }
    //MARK: --UI
    func initUI() {
        
    }
    //wechat
    @IBAction func wechatBtnTapped(_ sender: UIButton) {
        let req = SendAuthReq.init()
        req.scope = AppConst.WechatKey.Scope
        req.state = AppConst.WechatKey.State
        WXApi.send(req)
    }
    func errorCode(_ notice: NSNotification) {
        if let errorCode: Int = notice.object as? Int{
            if errorCode == -4{
                
                return
            }
            if errorCode == -2{
                
                return
            }
            dismissController()
            if loginComplete != nil{
                loginComplete!("" as AnyObject?)
            }
        }
        
    }
    //sina
    @IBAction func sinaBtnTapped(_ sender: UIButton) {
        
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismissController()
    }
}
