//
//  GoodsTableViewController.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/4.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit

class GoodsTableViewController: UITableViewController {

    let identifier = "GoodsCell"
    var dataShow:[String] = []
    var dataGood :[BADataGoods] = []
    
    var selectedCellIndexPath:IndexPath!
    
    // 添加按钮
    @IBAction func addGoods(_ sender: UIBarButtonItem) {
        // 设置新增商品
        BADataObject.shareInstance().editGood = nil
        // 弹出添加商品窗口
        self.performSegue(withIdentifier: "GoodsAppend", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UINib(nibName:"DetailTableViewCell", bundle:nil), forCellReuseIdentifier: self.identifier)

        self.tableView!.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        BADataObject.shareInstance().refreshTypeData(includeDelete: true)
        dataGood = BADataObject.shareInstance().getAllGoodsData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataGood.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != indexPath {
            self.tableView!.deselectRow(at: indexPath, animated: true)
            selectedCellIndexPath = indexPath
        }
        else {
            selectedCellIndexPath = nil
        }
        // Forces the table view to call heightForRowAtIndexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(selectedCellIndexPath != nil && selectedCellIndexPath == indexPath){
            return 150
        }
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! DetailTableViewCell
        
        cell.layer.masksToBounds = true
        // Configure the cell...
        let title = "\(dataGood[indexPath.row].name)"
        let type = "\(dataGood[indexPath.row].typeString)"
        cell.labelName?.text = title
        var sell = 0.0
        if let data = Double(dataGood[indexPath.row].sell) {
            sell = data
        }
        
        cell.labelSell?.text = "售价：\(sell)"
        cell.labelCount?.text = "库存：\(dataGood[indexPath.row].count)"
        var purchase = 0.0, purchase_other = 0.0
        if let data = Double(dataGood[indexPath.row].purchase) {
            purchase = data
        }
        if let data = Double(dataGood[indexPath.row].purchase_other) {
            purchase_other = data
        }
        
        cell.labelPurchase?.text = "成本：\(purchase)+\(purchase_other)"
        let profit = sell - purchase - purchase_other
        cell.labelProfit?.text = "利润：\(profit)"
        cell.labelType?.text = "类型：\(type)"
        cell.labelProxy?.text = "代理价格：\(dataGood[indexPath.row].proxy)"
        cell.labelNote?.text = dataGood[indexPath.row].note
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            //创建“旗标”事件按钮
            let edit = UITableViewRowAction(style: .normal, title: "编辑") {
                action, index in
                BADataObject.shareInstance().editGood = self.dataGood[index.row]
                // 弹出修改商品窗口
                self.performSegue(withIdentifier: "GoodsAppend", sender: nil)
                
            }
            edit.backgroundColor = UIColor.orange
            
            //创建“删除”事件按钮
            let delete = UITableViewRowAction(style: .normal, title: "删除") {
                action, index in
                //将对应条目的数据删除
                
                BADataObject.shareInstance().deleteGoodsData(goodID: self.dataGood[indexPath.row].id)
                self.dataGood = BADataObject.shareInstance().getAllGoodsData()
                tableView.reloadData()
            }
            delete.backgroundColor = UIColor.red
            
            //返回所有的事件按钮
            return [delete, edit]
    }
    
 /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            BADataObject.shareInstance().deleteGoodsData(at: indexPath.row)
            //刷新tableview
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }*/

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
