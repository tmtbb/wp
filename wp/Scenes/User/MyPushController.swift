//
//  MyPushController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
private let originalCellId = "MyPushCell"
class MyPushController: BasePageListTableViewController {

    let pushNumber = UILabel()
    let pushToday = UILabel()
    let pushWeek = UILabel()
    let pushMonthly = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = setupHeaderView()

        
    }
    func backDidClick() {
      _ = navigationController?.popToRootViewController(animated: true)

    }
    
    func setupHeaderView()->(UIView) {
        let bigSumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        let sumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        sumView.backgroundColor = UIColor(rgbHex:0xFFFFFF)
        let imageView = UIImageView(image: UIImage(named: "icon-13.png"))
        let grayView = UIView()
        sumView.addSubview(pushNumber)
        sumView.addSubview(pushToday)
        sumView.addSubview(pushWeek)
        sumView.addSubview(pushMonthly)
        sumView.addSubview(imageView)
        bigSumView.addSubview(sumView)
        bigSumView.addSubview(grayView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(sumView).offset(18)
            make.top.equalTo(sumView).offset(17)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        pushNumber.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.top.equalTo(sumView).offset(18)
            make.height.equalTo(15)
        }
        pushNumber.text = "推单总数: 20"
        pushNumber.sizeToFit()
        pushNumber.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushNumber.textColor = UIColor(rgbHex:0x333333)
        //本月
        pushMonthly.snp.makeConstraints { (make) in
            make.right.equalTo(sumView).offset(-15)
            make.top.equalTo(sumView).offset(18)
            make.height.equalTo(15)
        }
        pushMonthly.text = "本月8"
        pushMonthly.sizeToFit()
        pushMonthly.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushMonthly.textColor = UIColor(rgbHex:0x333333)
        //本周
        pushWeek.snp.makeConstraints { (make) in
            make.right.equalTo(pushMonthly.snp.left).offset(-20)
            make.top.equalTo(pushMonthly)
            make.height.equalTo(15)
        }
        pushWeek.text = "本周3"
        pushWeek.sizeToFit()
        pushWeek.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushWeek.textColor = UIColor(rgbHex:0x333333)
        //今日
        pushToday.snp.makeConstraints { (make) in
            make.right.equalTo(pushWeek.snp.left).offset(-20)
            make.top.equalTo(pushMonthly)
            make.height.equalTo(15)
        }
        pushToday.text = "今日3"
        pushToday.sizeToFit()
        pushToday.font = UIFont.systemFont(ofSize: 16 * (UIScreen.main.bounds.width / 375))
        pushToday.textColor = UIColor(rgbHex:0x333333)
        
        //灰色的线
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(sumView.snp.bottom)
            make.left.equalTo(bigSumView)
            make.right.equalTo(bigSumView)
            make.bottom.equalTo(bigSumView)
        }
        grayView.backgroundColor = UIColor(rgbHex:0xF6F7FB)
        
        return bigSumView
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBarWithAnimationDuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarWithAnimationDuration()
        translucent(clear: false)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: originalCellId, for: indexPath) as! MyPushCell
//
//        return cell
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.item == 0 {
            print("0")
        }
    }
    
    override func didRequest(_ pageIndex : Int){
        didRequestComplete(["",""] as AnyObject)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
