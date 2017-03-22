//
//  UIImage+Extension.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation
import Qiniu


extension UIImage{
    /**
     七牛上传图片
     
     - parameter image:     图片
     - parameter imageName: 图片名
     - parameter complete:  图片完成Block
     */
    class func qiniuUploadImage(image: UIImage, imageName: String, complete: CompleteBlock?, error: ErrorBlock?) {
        
        //0,将图片存到沙盒中
        let filePath = cacheImage(image, imageName: imageName)
        //1,获取图片
        AppAPIHelper.commen().imageToken(complete: { (resultObject) -> ()? in
            if let result: NSDictionary = resultObject as? NSDictionary{
                let token = result.value(forKey: "img_token_") as! String
                //2,上传图片
                let timestamp = NSDate().timeIntervalSince1970
                let key = "\(imageName)\(Int(timestamp)).png"
                let qiniuManager = QNUploadManager()
                qiniuManager?.putFile(filePath, key: key, token: token, complete: { (info, key, resp) in
                    if resp == nil{
                        complete!(nil)
                        return
                    }
                    //3,返回URL
                    let respDic: NSDictionary? = resp as NSDictionary?
                    let value:String? = respDic!.value(forKey: "key") as? String
                    let imageUrl = AppConst.Network.qiniuHost+value!
                    //4.回掉
                    if complete == nil {
                        return
                    }
                    complete!(imageUrl as AnyObject?)
                }, option: nil)
            }
            return nil
        }, error: error)
    }
    
    /**
     缓存图片
     
     - parameter image:     图片
     - parameter imageName: 图片名
     - returns: 图片沙盒路径
     */
    class func cacheImage(_ image: UIImage ,imageName: String) -> String {
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
    
    
    class func imageFromUIView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return viewImage!
    }
}
