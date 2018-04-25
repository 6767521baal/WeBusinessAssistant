//
//  CustomerAppendViewController.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/25.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit
import SwiftForms

class CustomerAppendViewController: FormViewController {

    struct StaticTag {
        static let nameTag = "name"
        static let proxyTag = "proxy"
        static let telephoneTag = "telephone"
        static let addressTag = "address"
        static let noteTag = "note"
    }
    
    @IBAction func backToCustomer(_ sender: UIBarButtonItem) {
        // 返回客户管理
        self.presentingViewController!.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func appendFinish(_ sender: UIBarButtonItem) {
        // 返回客户管理
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    fileprivate func loadForm() {
        
        let form :FormDescriptor
        if BADataObject.shareInstance().editGood == nil {
            form = FormDescriptor(title: "添加客户")
        }
        else {
            form = FormDescriptor(title: "修改客户")
        }
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: StaticTag.nameTag, type: .text, title: "客户姓名*")
        row.configuration.cell.appearance = ["textField.placeholder" : "客户姓名" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject, "textField.textColor" : UIColor.red as AnyObject]
        section1.rows.append(row)
        
        
        form.sections = [section1]
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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
