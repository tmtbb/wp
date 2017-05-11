//
//  AppServerHelper.swift
//  wp
//
//  Created by 木柳 on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Alamofire

class AppServerHelper: NSObject , WXApiDelegate{
    fileprivate static var helper = AppServerHelper()
    
    class func instance() -> AppServerHelper{
        return helper
    }
    
    func initServer() {
        checkUpdate()
        initFabric()
        wechat()
    }
    
    //Fabric
    func initFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    //查询是否有新版本更新
    func checkUpdate() {
        print(UIDevice.current.systemVersion)
        AppAPIHelper.commen().update(type: 0, complete: { result in
            if let param = result as? UpdateParam{
                param.haveUpate = Double(param.newAppVersionName)! > Double(UIDevice.current.systemVersion)!
                UserModel.share().updateParam = param
            }
            return nil
        }, error: nil)
    }
    
    
    //MARK: --Wechat
    fileprivate func wechat() {
        WXApi.registerApp("wx9dc39aec13ee3158")
    }
    func onResp(_ resp: BaseResp!) {
        //微信登录返回
        if resp.isKind(of: SendAuthResp.classForCoder()) {
            let authResp:SendAuthResp = resp as! SendAuthResp
            if authResp.errCode == 0{
                accessToken(code: authResp.code)
            }
            return
        }
        
        // 支付返回
        if resp.isKind(of: PayResp.classForCoder()) {
            let authResp:PayResp = resp as! PayResp
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatPay.WechatKeyErrorCode), object: NSNumber.init(value: authResp.errCode), userInfo:nil)
            
            return
        }
    }
    
    func accessToken(code: String) {
        let param = [SocketConst.Key.appid : AppConst.WechatKey.Appid,
                     "code" : code,
                     SocketConst.Key.secret : AppConst.WechatKey.Secret,
                     SocketConst.Key.grant_type : "authorization_code"]
    
        Alamofire.request(AppConst.WechatKey.AccessTokenUrl, method: .get, parameters: param).responseJSON { [weak self](result) in
            if let resultJson = result.result.value as? [String: AnyObject] {
                if let errCode = resultJson["errcode"] as? Int{
                    print(errCode)
                }
                if let access_token = resultJson[SocketConst.Key.accessToken] as? String {
                    if let openid = resultJson[SocketConst.Key.openid] as? String{
                        self?.wechatUserInfo(token: access_token, openid: openid)
                    }
                }
            }
        }
    }
    
    func wechatUserInfo(token: String, openid: String){
        let param = [SocketConst.Key.accessToken : token,
                     SocketConst.Key.openid : openid]
        Alamofire.request(AppConst.WechatKey.wechetUserInfo, method: .get, parameters: param).responseJSON {(result) in
            guard let resultJson = result.result.value as? [String: AnyObject] else{return}
            if let errCode = resultJson["errcode"] as? Int{
                print(errCode)
            }
            if let nickname = resultJson[SocketConst.Key.nickname] as? String {
                UserModel.share().wechatUserInfo[SocketConst.Key.nickname] = nickname
            }
            if let openid = resultJson[SocketConst.Key.openid] as? String{
                UserModel.share().wechatUserInfo[SocketConst.Key.openid] = openid
            }
            if let headimgurl = resultJson[SocketConst.Key.headimgurl] as? String{
                UserModel.share().wechatUserInfo[SocketConst.Key.headimgurl] = headimgurl
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: nil, userInfo:nil)
        }
    }
}
