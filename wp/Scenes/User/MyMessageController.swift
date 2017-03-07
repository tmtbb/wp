//
//  MyMessageController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKNightVersion
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
        if ((UserModel.share().getCurrentUser()?.avatarLarge) != ""){
            userImage.image = UIImage(named: "\(UserModel.share().getCurrentUser()?.avatarLarge)")
            userImage.image = UIImage(named: "default-head")
        }
        else{
            userImage.image = UIImage(named: "default-head")
        }
        if ((UserModel.share().getCurrentUser()?.screenName) != "") {
            userName.text = UserModel.share().getCurrentUser()?.screenName
            userName.sizeToFit()
            tableView.reloadData()
        }
        else{
            userName.text = "---"
        }


////        let four : String = (UserModel.getCurrentUser()?.phone)!
//        let str : String = (four as NSString).substring(to: 4)
//        let str2 : String = (four as NSString).substring(from: 7)
//        phoneNumber.text = str + "****" + str2

        let four : String = UserModel.share().getCurrentUser()?.phone ?? "00000000000"
        let str : String = (four as NSString).substring(to: 4)
        let str2 : String = (four as NSString).substring(from: 7)
        phoneNumber.text = str + "****" + str2

    }
    
   
    func setupFooterView()->(UIView) {
        let footerView =  UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let footerBtn = UIButton()
        footerBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
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
        _ = navigationController?.popToRootViewController(animated: true)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        if indexPath.section == 1{
            let alertController = UIAlertController(title: "修改昵称", message: nil, preferredStyle: UIAlertControllerStyle.alert);
            alertController.addTextField { [weak self](textField:UITextField!) -> Void in
                textField.text = self?.userName.text
            }
            let alterActionSecond:UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { [weak self](ACTION) -> Void in
                
                let filed = alertController.textFields!.first! as UITextField
                
                 SVProgressHUD.show()
                //七牛没有连接通.暂时还没拿到照片的URL
                AppAPIHelper.user().revisePersonDetail(screenName: filed.text!, avatarLarge: UserModel.share().getCurrentUser()?.avatarLarge ?? "", gender: 0, complete: { [weak self](result) -> ()? in
                    
                    if result == nil {
                      
                        UserModel.updateUser(info: { (result) -> ()? in
                           UserModel.share().getCurrentUser()?.screenName = filed.text
                        })
                        self?.userName.text = filed.text
                        SVProgressHUD.show(withStatus: "修改昵称成功")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.ChangeUserinfo), object: nil, userInfo: nil)
                        
                        SVProgressHUD.dismiss()
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
            
            let story : UIStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
            
            let registvc : RegisterVC  = story.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            
            UserModel.share().forgetPwd = true
            UserModel.share().forgetType = .dealPass
            self.navigationController?.pushViewController(registvc, animated: true)
        }
        //登录密码
        if indexPath.section == 2{
            let story : UIStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
            
            let registvc : RegisterVC  = story.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            
            UserModel.share().forgetPwd = true
            UserModel.share().forgetType = .loginPass
            self.navigationController?.pushViewController(registvc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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
        UIImage.qiniuUploadImage(image: image, imageName: "\(Int(Date.nowTimestemp()))", complete: { (result) -> ()? in
            
            print(result!)
            //七牛请求回来url地址  上传到服务器.成功之后.保存到UserModel.share().getCurrentUser()?.avatarLarge 在通知 更新UI
            
            return nil
        }) { (error) -> ()? in
            print(error)
            return nil
        }
    }
}
