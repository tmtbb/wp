//
//  QRCodeVC.swift
//  wp
//
//  Created by mu on 2017/4/28.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
import SVProgressHUD

class QRCodeVC: UIViewController {
    @IBOutlet weak var qrcodeImage: UIImageView!
    @IBOutlet weak var qrTitleLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = nil
        navigationItem.hidesBackButton = true
        
        qrcodeImage.image = UIImage.qrcodeImage(UserModel.share().qrcodeStr)
        qrTitleLabel.text = UserModel.share().qrcodeTitle
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        
        let longGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(saveImageToAlbum))
        qrcodeImage.isUserInteractionEnabled = true
        qrcodeImage.addGestureRecognizer(longGesture)
    }
    
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        _  = navigationController?.popViewController(animated: true)
    }
  
    func saveImageToAlbum() {
        let actionController = UIAlertController.init(title: "保存图片", message: "保存图片到相册", preferredStyle: .alert)
        let cancelAlter = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        actionController.addAction(cancelAlter)
        let sureAction = UIAlertAction.init(title: "确认", style: .default, handler: { [weak self](result) in
            SVProgressHUD.showProgressMessage(ProgressMessage: "保存中")
            UIImageWriteToSavedPhotosAlbum((self?.qrcodeImage.image)!, self, #selector(self?.savedOK(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        actionController.addAction(sureAction)
        present(actionController, animated: true, completion: nil)

    }
    
    // 提示：参数 空格 参数别名: 类型
    func savedOK(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        SVProgressHUD.dismiss()
        if error != nil {
            SVProgressHUD.showErrorMessage(ErrorMessage: error!.localizedDescription, ForDuration: 1.5, completion: nil)
            return
        }
        SVProgressHUD.showSuccessMessage(SuccessMessage: "保存成功", ForDuration: 1.5, completion: nil)
        
    }
}
