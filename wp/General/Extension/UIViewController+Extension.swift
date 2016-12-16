//
//  UIViewController+Extension.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation
//import XCGLogger
import SVProgressHUD
import Qiniu
extension UIViewController {
    
    static func storyboardViewController<T:UIViewController>(_ storyboard:UIStoryboard) ->T {
        return storyboard.instantiateViewController(withIdentifier: T.className()) as! T;
    }
    
    func storyboardViewController<T:UIViewController>() ->T {
        
        return storyboard!.instantiateViewController(withIdentifier: T.className()) as! T;
    }
    
    
    func errorBlockFunc()->ErrorBlock {
        return { [weak self] (error) in
//            XCGLogger.error("\(error) \(self)")
            self?.didRequestError(error)
        }
    }
    
    func didRequestError(_ error:NSError) {
        let errorMsg = AppConst.errorMsgs[Int(error.code)]
        self.showErrorWithStatus(errorMsg)
    }
   
    func showErrorWithStatus(_ status: String!) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    func showWithStatus(_ status: String!) {
        SVProgressHUD.show(withStatus: status)
    }
    
    //MARK: -Common function
    func checkTextFieldEmpty(_ array:[UITextField]) -> Bool {
        for  textField in array {
            if NSString.isEmpty(textField.text)  {
                showErrorWithStatus(textField.placeholder);
                return false
            }
        }
        return true
    }
    
    func dismissController() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    
    
    /**
     缓存图片
     
     - parameter image:     图片
     - parameter imageName: 图片名
     - returns: 图片沙盒路径
     */
    func cacheImage(_ image: UIImage ,imageName: String) -> String {
        let data = UIImageJPEGRepresentation(image, 0.5)
        let homeDirectory = NSHomeDirectory()
        let documentPath = homeDirectory + "/Documents/"
        let fileManager: FileManager = FileManager.default
        do {
            try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
        }
        catch _ {
        }
        let key = "\(imageName).png"
        fileManager.createFile(atPath: documentPath + key, contents: data, attributes: nil)
        //得到选择后沙盒中图片的完整路径
        let filePath: String = String(format: "%@%@", documentPath, key)
        return filePath
    }
    
    func didActionTel(_ telPhone:String) {
        let alert = UIAlertController.init(title: "呼叫", message: telPhone, preferredStyle: .alert)
        let ensure = UIAlertAction.init(title: "确定", style: .default, handler: { (action: UIAlertAction) in
            UIApplication.shared.openURL(URL(string: "tel://\(telPhone)")!)
        })
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action: UIAlertAction) in
            
        })
        alert.addAction(ensure)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}
