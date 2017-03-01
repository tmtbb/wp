//
//  MyAttentionController.swift
//  wp
//
//  Created by macbook air on 16/12/23.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
class MyAttentionCell: OEZTableViewCell {
    @IBOutlet weak var nuberLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //    var array = []{
    //        didset{
    //
    //        }
    //    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
class MyAttentionController: BasePageListTableViewController {

    var attentionNumber = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = setupHeaderView()

    }
    func backDidClick() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: -- 头视图
    func setupHeaderView() -> (UIView){
        let sumView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 49))
        let attentionHint = UILabel()
        attentionHint.text = "关注的人数:"
        attentionHint.font = UIFont.systemFont(ofSize: 16)
        sumView.addSubview(attentionHint)
        attentionHint.snp.makeConstraints { (make) in
            make.left.equalTo(sumView).offset(15)
            make.top.equalTo(sumView).offset(20)
            make.height.equalTo(15)
        }
        sumView.addSubview(attentionNumber)
        attentionNumber.snp.makeConstraints { (make) in
            make.left.equalTo(attentionHint.snp.right).offset(2)
            make.top.equalTo(attentionHint)
            make.height.equalTo(attentionHint)
        }
        attentionNumber.text = " 10"
        attentionNumber.font = UIFont.systemFont(ofSize: 16)
        return sumView
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

//    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAttentionCell", for: indexPath) as! MyAttentionCell
//        let index = indexPath.item
//        cell.nuberLabel.text = "\(index + 1)"        
//        
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
