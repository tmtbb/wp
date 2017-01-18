//
//  FriendShareView.swift
//  wp
//
//  Created by sum on 2017/1/18.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class FriendShareView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
       
    }
    func setupSubviews(){
        
        let story : UIStoryboard = UIStoryboard.init(name: "Share", bundle: nil)
        let vc : ShareFriendVC =  story.instantiateViewController(withIdentifier: "ShareFriendVC") as! ShareFriendVC
       
        
        self.addSubview(vc.view)
        
        
        vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
      
        
        
        
    }

}
