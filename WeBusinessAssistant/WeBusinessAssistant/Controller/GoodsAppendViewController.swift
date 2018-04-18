//
//  GoodsAppendViewController.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/13.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit
import SwiftForms

class GoodsAppendViewController: FormViewController {
    
    struct StaticTag {
        static let nameTag = "name"
        static let typeTag = "type"
        static let purchaseTag = "purchase"
        static let purchase_otherTag = "purchase_other"
        static let sellTag = "sell"
        static let proxyTag = "proxy"
        static let noteTag = "note"
    }
    
    @IBAction func backToGoodsManagement(_ sender: UIBarButtonItem) {
        // 返回商品管理
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func appendFinish(_ sender: UIBarButtonItem) {
        // 新增商品入库
        let data = BADataGoods()
        let goodAppend = self.form.formValues()
        print("\(self.form.formValues().description)")
        data.name = goodAppend[StaticTag.nameTag] as! String
        switch goodAppend[StaticTag.typeTag] as! Int64 {
        case 0:
            data.type = "保健品"
        case 1:
            data.type = "美妆"
        case 2:
            data.type = "婴儿用品"
        default:
            data.type = "其他"
        }
        if let purchase = goodAppend[StaticTag.purchaseTag] as? String {
            data.purchase = purchase
        }
        if let purchase_other = goodAppend[StaticTag.purchase_otherTag] as? String {
            data.purchase_other = purchase_other
        }
        if let sell = goodAppend[StaticTag.sellTag] as? String {
            data.sell = sell
        }
        if let proxy = goodAppend[StaticTag.proxyTag] as? String {
            data.proxy = proxy
        }
        if let note = goodAppend[StaticTag.noteTag] as? String {
            data.note = note
        }
        
        if BADataObject.shareInstance().addGoodData(data: data) {
            print("添加商品成功！\n")
        }
        
        // 返回商品管理
        //self.performSegue(withIdentifier: "Return", sender: nil)
        let sb = UIStoryboard(name:"Main", bundle: nil)
        
        let listController = sb.instantiateViewController(withIdentifier: "MainTabBarController") as! MainController
        listController.selectedIndex=1
        self.present(listController, animated: true, completion: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "添加商品")
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: StaticTag.nameTag, type: .text, title: "商品名称*")
        row.configuration.cell.appearance = ["textField.placeholder" : "商品名称" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject, "textField.textColor" : UIColor.red as AnyObject]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: StaticTag.typeTag, type: .picker, title: "商品类型*")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = ([0, 1, 2, 3] as [AnyObject]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "其他" }
            switch option {
            case 0:
                return "保健品"
            case 1:
                return "美妆"
            case 2:
                return "婴儿用品"
            default:
                return "其他"
            }
        }
        
        row.value = 3 as AnyObject
        row.configuration.cell.appearance["valueLabel.textColor"] = UIColor.red
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: StaticTag.purchaseTag, type: .decimal, title: "商品成本")
        row.configuration.cell.appearance = ["textField.placeholder" : "0.00" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: StaticTag.purchase_otherTag, type: .decimal, title: "其他成本")
        row.configuration.cell.appearance = ["textField.placeholder" : "0.00" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: StaticTag.sellTag, type: .decimal, title: "商品售价")
        row.configuration.cell.appearance = ["textField.placeholder" : "0.00" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: StaticTag.proxyTag, type: .decimal, title: "代理价")
        row.configuration.cell.appearance = ["textField.placeholder" : "0.00" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: StaticTag.noteTag, type: .text, title: "备注说明")
        row.configuration.cell.appearance = ["textField.placeholder" : "备注说明" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        form.sections = [section1, section2, section3]
        
        self.form = form
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
/*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
