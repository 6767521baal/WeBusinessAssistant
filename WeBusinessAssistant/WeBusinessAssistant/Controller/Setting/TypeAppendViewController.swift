//
//  TypeAppendViewController.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/24.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit

class TypeAppendViewController: UIViewController {

    var dataType = BADataType()
    
    @IBOutlet weak var textType: UITextField!
    
    @IBAction func saveType(_ sender: UIButton) {
        let name = textType.text
        if name != nil && !(name?.isEmpty)! {
            if BADataObject.shareInstance().editType == nil {
                // 新增商品类型信息
                dataType.name = name!
                if BADataObject.shareInstance().addTypeData(data: dataType) {
                    print("新增商品类型成功！\n")
                }
            }
            else {
                // 修改商品类型信息
                if BADataObject.shareInstance().updateTypeData(typeID: dataType.id, name: textType.text!, delete: dataType.delete){
                    print("修改商品类型成功！\n")
                }
            }
            // 返回商品类型管理
            self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
        else {
            
            // 提示
            let alertController = UIAlertController(title: "提示",
                                                    message: "请填写商品类型名称。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backToTypeManage(_ sender: UIBarButtonItem) {
        // 返回商品类型管理
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if BADataObject.shareInstance().editType == nil {
            // 新增商品类型
            self.title = "新增类型"
        }
        else {
            // 修改商品类型
            self.title = "修改类型"
            dataType = BADataObject.shareInstance().editType!
            textType.text = dataType.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
