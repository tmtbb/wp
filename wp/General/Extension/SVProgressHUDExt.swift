//
//  SVProgressHUDExt.swift
//  HappyTravel
//
//  Created by 木柳 on 2016/11/2.
//  Copyright © 2016年 陈奕涛. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD{
    
    public class func showErrorMessage(ErrorMessage message: String, ForDuration duration: Double, completion: (() -> Void)?) {
        initStyle()
        SVProgressHUD.showError(withStatus: message)
        dismissWithDuration(Duration: duration,completion:completion)
    }
    
    public class func showSuccessMessage(SuccessMessage message: String, ForDuration duration: Double, completion: (() -> Void)?){
        initStyle()
        SVProgressHUD.showSuccess(withStatus: message)
        dismissWithDuration(Duration: duration,completion:completion)
    }
    
    public class func showWainningMessage(WainningMessage message: String, ForDuration duration: Double, completion: (() -> Void)?){
        initStyle()
        SVProgressHUD.showInfo(withStatus: message)
        dismissWithDuration(Duration: duration,completion:completion)
    }
    
    public class func showProgressMessage(ProgressMessage message: String){
        initStyle()
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.dismissWithDuration(Duration: 15, completion: nil)
    }

    public class func initStyle(){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.none)
    }
    
    public class func dismissWithDuration(Duration duration: Double,completion: (() -> Void)?){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64 (duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            SVProgressHUD.dismiss()
            if ((completion) != nil) {
                completion!()
            }
        })
    }
}
