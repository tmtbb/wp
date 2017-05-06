
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
        return ""
    }
    
    func isMoneyString() -> Bool {
        if self.length() == 0{
            return true
        }
        
        let money = self as NSString
        if money.range(of: ".").location == NSNotFound {
            return true
        }
        let leftMoneyStr = money.substring(from: money.range(of: ".").location+1) as NSString
        if leftMoneyStr.range(of: ".").location != NSNotFound {
            return false
        }
        return leftMoneyStr.length <= 2
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    func md5() ->String!{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
}
