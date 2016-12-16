//
//  EmojiFaceHelper.swift
//  viossvc
//
//  Created by abx’s mac on 2016/12/6.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class EmojiFaceHelper: NSObject {
    static let shared  = EmojiFaceHelper()
    
    fileprivate var m_faceArray  = [String]()
    func getFaceArray() -> [String] {
        return m_faceArray
    }
    
    
    override init() {
       super.init()
        initFace()

    }
    
   fileprivate func EMOJI_CODE_TO_SYMBOL(_ x : UInt64) -> UInt64 {
        let sym = (((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24
        return   UInt64(sym)
    }
    
   fileprivate func MULITTHREEBYTEUTF16TOUNICODE(_ x : Int , y : Int) -> Int {
        return (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000
    }
    

    fileprivate   func xStringReplaceEmoji(_ array: [Int]) -> NSString {
        
        
        let bytes = array
        let data = Data(bytes: UnsafePointer(bytes), count: bytes.count)
        let dogString = NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)
        return dogString == nil ? "" : dogString!
    }
    
    fileprivate   func emojiStringArray(_ array: [[Int]]) -> [String] {
        
        var  emojiArray = [String]()
        for bytes in array {
            emojiArray.append(xStringReplaceEmoji(bytes) as String)
        }
        return emojiArray
    }

    fileprivate   func initFace() {
        var count:Int = 0
        for i  in 0x1F600...0x1F69F {
            if i < 0x1F641 || ( i > 0x1F644 && i < 0x1F650) || i > 0x1F67F {
                var sym = EMOJI_CODE_TO_SYMBOL(UInt64(i))
                
               let emojiT = NSString(bytes: &sym , length: 4, encoding: String.Encoding.utf8.rawValue)
                m_faceArray.append(emojiT as! String)
                 count += 1
                if count % 27 == 0 {
                    m_faceArray.append("")
                }
                
            }
        }
    }

}
