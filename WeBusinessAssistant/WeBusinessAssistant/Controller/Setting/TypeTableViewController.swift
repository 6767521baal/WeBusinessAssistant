//
//  TypeTableViewController.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/24.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {

    let identifier = "TypeCell"
    
    var dataType :[BADataType] = []
    
    @IBAction func backToSetting(_ sender: UIBarButtonItem) {
        // 返回设置页面
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    @IBAction func typeAppend(_ sender: UIBarButtonItem) {
        BADataObject.shareInstance().editType = nil
        // 弹出添加商品类型窗口
        self.performSegue(withIdentifier: "TypeAppend", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataType = BADataObject.shareInstance().getAllTypeData()
        tableView.reloadData()
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
        return dataType.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath)
        
        cell.textLabel?.text = dataType[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        BADataObject.shareInstance().editType = dataType[indexPath.row]
        // 弹出添加商品类型窗口
        self.performSegue(withIdentifier: "TypeAppend", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            //创建“删除”事件按钮
            let delete = UITableViewRowAction(style: .normal, title: "删除") {
                action, index in
                //将对应条目的数据删除
                BADataObject.shareInstance().deleteTypeData(typeID: self.dataType[indexPath.row].id)
                self.dataType = BADataObject.shareInstance().getAllTypeData(refreshDelete: true)
                tableView.reloadData()
            }
            delete.backgroundColor = UIColor.red
            
            //返回所有的事件按钮
            return [delete]
    }
}
