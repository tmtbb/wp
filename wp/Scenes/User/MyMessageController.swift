//
//  MyMessageController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class MyMessageController: BaseTableViewController {
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        translucent(clear: false)
        tableView.tableFooterView = setupFooterView()
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        backBtn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backDidClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        if ((UserModel.getCurrentUser()?.avatarLarge) != ""){
            userImage.image = UIImage(named: "\(UserModel.getCurrentUser()?.avatarLarge)")
        }
        else{
            userImage.image = UIImage(named: "default-head")
        }
        if ((UserModel.getCurrentUser()?.screenName) != "") {
            userName.text = UserModel.getCurrentUser()?.screenName
            userName.sizeToFit()
        }
        else{
            userName.text = "Bug退散"
        }
    
        let four : String = (UserModel.getCurrentUser()?.phone)!
        
        let str : String = (four as NSString).substring(to: 4)
        let str2 : String = (four as NSString).substring(from: 7)
        
        phoneNumber.text = str + "****" + str2
            
        
        

    }
   
    func backDidClick() {
        navigationController?.popToRootViewController(animated: true)
    }
    func setupFooterView()->(UIView) {
        let footerView =  UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let footerBtn = UIButton()
        footerBtn.backgroundColor = UIColor(rgbHex: 0xE9573E)
        footerBtn.layer.cornerRadius = 10
        footerBtn.layer.masksToBounds = true
        footerBtn.setTitle("退出登录", for: .normal)
        footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        footerBtn.contentHorizontalAlignment = .center
        footerBtn.setTitleColor(UIColor(rgbHex: 0xFFFFFF), for: .normal)
        footerBtn.addTarget(self, action: #selector(quitEnterClick), for: .touchUpInside)
        footerView.addSubview(footerBtn)
        footerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(footerView).offset(15)
            make.right.equalTo(footerView).offset(-15)
            make.top.bottom.equalTo(footerView)
        }
        return footerView
    }
    //监听退出登录按钮
    func quitEnterClick() {
        
        userLogout()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.QuitEnterClick), object: nil)
        navigationController?.popToRootViewController(animated: true)
        print("退出登录")
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if  section == 2 {
            return 10
        }
        if section == 4 {
            return 50
        }
        return 0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        translucent(clear: true)
        showTabBarWithAnimationDuration()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePicker.delegate = self
        tabBarController?.tabBar.isHidden = true
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //更改头像
        if indexPath.section == 0 {
            
            imagePicker.sourceType = .photoLibrary
            present((imagePicker), animated: true, completion: nil)
        }
        //昵称修改
        if indexPath.section == 2{
            let alertController = UIAlertController(title: "修改昵称", message: nil, preferredStyle: UIAlertControllerStyle.alert);
            alertController.addTextField { [weak self](textField:UITextField!) -> Void in
                textField.text = self?.userName.text
            }
            let alterActionSecond:UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { [weak self](ACTION) -> Void in
                
                let filed = alertController.textFields!.first! as UITextField
                
                //七牛没有连接通.暂时还没拿到照片的URL
                AppAPIHelper.user().revisePersonDetail(screenName: filed.text!, avatarLarge: "1111", gender: 0, complete: { [weak self](result) -> ()? in
                    
                    if result != nil {
                      self?.userName.text = filed.text
                        UserModel.updateUser(info: { (result) -> ()? in
                           UserModel.share().currentUser?.screenName = filed.text
                        })
                        
                        return nil
                    }
                    return nil
                }, error: self?.errorBlockFunc())
                
                
            })
            let alterActionCancel: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(alterActionSecond)
            alertController.addAction(alterActionCancel)
            present(alertController, animated: true, completion: nil)
        }
        //交易密码
        if indexPath.section == 3 {
            performSegue(withIdentifier: DealPasswordVC.className(), sender: nil)
        }
        //登录密码
        if indexPath.section == 4{
            performSegue(withIdentifier: EnterPasswordVC.className(), sender: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MyMessageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        userImage.image = image
        UIImage.qiniuUploadImage(image: image, imageName: "test", complete: { (result) -> ()? in
            
            print(result!)
    
            
            return nil
        }) { (error) -> ()? in
            print(error)
            return nil
        }

    
   
        
    }
}
