
//
//  String.swift
//  viossvc
//
//  Created by yaowang on 2016/11/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
extension String {
    func trim() -> String {
        return  self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static func stringAttributes(_ font:UIFont,lineSpacing:CGFloat) ->[String:AnyObject]{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        return [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle]
    }
     func boundingRectWithSize(_ size:CGSize,font:UIFont,lineSpacing:CGFloat? = 5) ->CGRect {
        let attributedString = self.attributedString(font, lineSpacing: lineSpacing)
        return attributedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
    }
    
    func boundingStringWithSize(_ size:CGSize,font:CGFloat) ->CGRect {
        let string : NSString = self as NSString
    
        return  string.boundingRect(with: size, options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes:[NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil)
    }
    
    
    func attributedString(_ font:UIFont,lineSpacing:CGFloat? = 5) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(String.stringAttributes(font,lineSpacing:lineSpacing!), range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func length() -> Int {
        return self.characters.count
    }

    func sha256() -> String {
        let data: Data = self.data(using: .utf8)!
    
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &hash)
        }
        
        let hexBytes = hash.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    public static func ip() -> String {
//        var addresses = [String]()
        return ""
    }
}
