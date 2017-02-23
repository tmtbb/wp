//
//  FeedbackViewController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SnapKit
class FeedbackController: UIViewController {
    
    let textView: UITextView = UITextView()
    let placeholderLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "意见反馈"
        self.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeholderLabel.frame = CGRect(x: 5, y: 5, width: view.bounds.size.width, height: 20)
    }
    
    func setupUI() {
        
        textView.autocorrectionType = .no
        textView.delegate = self
        self.view.addSubview(textView)
        //设置约束
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(200)
        }
        
        setConfig()
        
    } 
    func setConfig() {
        
        textView.backgroundColor = UIColor(colorLiteralRed: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
        textView.isEditable = true
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        
        placeholderLabel.textColor = UIColor.gray
        placeholderLabel.text = "请输入反馈信息"
        
        textView.addSubview(placeholderLabel)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//MARK: --UITextViewDelegate
extension FeedbackController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.text = ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if placeholderLabel.text?.length() == 0 {
            placeholderLabel.text = "请输入内容"
        }
        else{
            placeholderLabel.text = ""
        }
    }
    
    
}



