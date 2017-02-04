//
//  EnterPasswordVC.swift
//  wp
//
//  Created by macbook air on 17/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class EnterPasswordVC: UIViewController {

    @IBOutlet weak var oldEnterPassword: UITextField!
    
    @IBOutlet weak var newEnterPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //确定按钮
    @IBAction func ensureBtn(_ sender: Any) {
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
