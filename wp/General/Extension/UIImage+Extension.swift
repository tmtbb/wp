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
    
    
    //根据字符串生成二维码
    class func qrcodeImage(_ qrcodeStr: String) -> UIImage?{
        
        //        1.创建一个滤镜
        let filter = CIFilter(name:"CIQRCodeGenerator")
        //        2.将滤镜恢复到默认状态
        filter?.setDefaults()
        //        3.为滤镜添加属性    （"函冰"即为二维码扫描出来的内容，可以根据需求进行添加）
        filter?.setValue(qrcodeStr.data(using: String.Encoding.utf8), forKey: "InputMessage")
        //        判断是否有图片
        guard let ciimage = filter?.outputImage else {
            return nil
        }
        //        4。将二维码赋给imageview,此时调用网上找的代码片段，由于SWift3的变化，将其稍微改动，生成清晰的二维码
        return createNonInterpolatedUIImageFormCIImage(image: ciimage, size: 200)
    }
    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private class func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = image.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        // 1.创建bitmap;
        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale);
        //        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        bitmapRef.draw(bitmapImage, in: extent)
        // 2.保存bitmap到图片
        let scaledImage: CGImage = bitmapRef.makeImage()!
        
        return UIImage(cgImage: scaledImage)
    }
}
