//
//  BACustomerTable.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/25.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation
import SQLite

/*  客户的数据库表 table_customer
 字段为
 customer_id                自增非空主键 与table_orders表的order_customer_id关联
 customer_name              客户名称
 customer_telephone         客户联系电话
 customer_address           客户收获地址
 customer_proxy             客户是否是代理，代理客户会在计算售价时使用代理价格。
 customer_note              客户备注
 customer_is_delete         客户删除标志,已删除客户不会在界面中显示，也无法在订单选择客户时被选择，但仍会被在已存在的订单中关联。
 
 提供基本的增、删、改、查功能
 获取所有客户(getAllItems)时，可以根据参数决定是否返回已被删除的客户(已被删除客户主要用于与现有订单的关联)
 */

struct DB_CUSTOMER {
    // 表名
    let TABLE_CUSTOMER = Table("table_customer")
    // 列名及类型
    let TABLE_CUSTOMER_ID = Expression<Int64>("customer_id")
    let TABLE_CUSTOMER_NAME = Expression<String>("customer_name")
    let TABLE_CUSTOMER_TELEPHONE = Expression<String>("customer_telephone")
    let TABLE_CUSTOMER_ADDRESS = Expression<String>("customer_address")
    let TABLE_CUSTOMER_PROXY = Expression<Int64>("customer_proxy")
    let TABLE_CUSTOMER_NOTE = Expression<String>("customer_note")
    let TABLE_CUSTOMER_DELETE = Expression<Int64>("customer_is_delete")
}

class BACustomerTable {

    let tableCustomer = DB_CUSTOMER()
    
    // 建表
    func createTable() -> Void {
        do { // 创建表
            try BADatabase.shareInstance().db.run(tableCustomer.TABLE_CUSTOMER.create { table in
                table.column(tableCustomer.TABLE_CUSTOMER_ID, primaryKey: .autoincrement)
                table.column(tableCustomer.TABLE_CUSTOMER_NAME)
                table.column(tableCustomer.TABLE_CUSTOMER_TELEPHONE)
                table.column(tableCustomer.TABLE_CUSTOMER_ADDRESS)
                table.column(tableCustomer.TABLE_CUSTOMER_PROXY)
                table.column(tableCustomer.TABLE_CUSTOMER_NOTE)
                table.column(tableCustomer.TABLE_CUSTOMER_DELETE)
            })
            print("创建表 table_customer 成功")
        } catch {
            print("创建表 table_customer 失败：\(error)")
        }
    }
    
    // 插入
    func insertItem(name: String, telephone: String, address: String, proxy: Int64, note: String, delete: Int64) -> Bool {
        let insert = tableCustomer.TABLE_CUSTOMER.insert(tableCustomer.TABLE_CUSTOMER_NAME <- name,  tableCustomer.TABLE_CUSTOMER_TELEPHONE <- telephone,  tableCustomer.TABLE_CUSTOMER_ADDRESS <- address,  tableCustomer.TABLE_CUSTOMER_PROXY <- proxy,  tableCustomer.TABLE_CUSTOMER_NOTE <- note,  tableCustomer.TABLE_CUSTOMER_DELETE <- delete)
        do {
            let rowid = try BADatabase.shareInstance().db.run(insert)
            print("插入数据成功 id: \(rowid)")
            return true
        } catch {
            print("插入数据失败: \(error)")
            return false
        }
    }
    
    // 遍历
    func queryAllItems() -> Void {
        for item in (try! BADatabase.shareInstance().db.prepare(tableCustomer.TABLE_CUSTOMER)) {
            print("客户 遍历 ———— id: \(item[tableCustomer.TABLE_CUSTOMER_ID]), name: \(item[tableCustomer.TABLE_CUSTOMER_NAME]), telephone: \(item[tableCustomer.TABLE_CUSTOMER_TELEPHONE]), address: \(item[tableCustomer.TABLE_CUSTOMER_ADDRESS]), proxy: \(item[tableCustomer.TABLE_CUSTOMER_PROXY]), note: \(item[tableCustomer.TABLE_CUSTOMER_NOTE]), delete: \(item[tableCustomer.TABLE_CUSTOMER_DELETE])")
        }
    }
    
    // 读取
    func readItem(name: String) -> [BADataCustomer] {
        var array :[BADataCustomer] = []
        for item in try! BADatabase.shareInstance().db.prepare(tableCustomer.TABLE_CUSTOMER.filter(tableCustomer.TABLE_CUSTOMER_NAME == name)) {
            print("客户 读取 ———— id: \(item[tableCustomer.TABLE_CUSTOMER_ID]), name: \(item[tableCustomer.TABLE_CUSTOMER_NAME]), telephone: \(item[tableCustomer.TABLE_CUSTOMER_TELEPHONE]), address: \(item[tableCustomer.TABLE_CUSTOMER_ADDRESS]), proxy: \(item[tableCustomer.TABLE_CUSTOMER_PROXY]), note: \(item[tableCustomer.TABLE_CUSTOMER_NOTE]), delete: \(item[tableCustomer.TABLE_CUSTOMER_DELETE])")
            let data = BADataCustomer()
            data.id = item[tableCustomer.TABLE_CUSTOMER_ID]
            data.name = item[tableCustomer.TABLE_CUSTOMER_NAME]
            data.telephone = item[tableCustomer.TABLE_CUSTOMER_TELEPHONE]
            data.address = item[tableCustomer.TABLE_CUSTOMER_ADDRESS]
            data.note = item[tableCustomer.TABLE_CUSTOMER_NOTE]
            if item[tableCustomer.TABLE_CUSTOMER_PROXY] == 1 {
                data.proxy = true
            }
            else {
                data.proxy = false
            }
            if item[tableCustomer.TABLE_CUSTOMER_DELETE] == 1 {
                data.delete = true
            }
            else {
                data.delete = false
            }
            array.append(data)
        }
        return array
    }
    
    
    // 获取全部商品
    func getAllItems(includeDelete :Bool = false) -> [BADataCustomer] {
        var array :[BADataCustomer] = []
        for item in (try! BADatabase.shareInstance().db.prepare(tableCustomer.TABLE_CUSTOMER)) {
            print("获取全部客户 ———— id: \(item[tableCustomer.TABLE_CUSTOMER_ID]), name: \(item[tableCustomer.TABLE_CUSTOMER_NAME]), telephone: \(item[tableCustomer.TABLE_CUSTOMER_TELEPHONE]), address: \(item[tableCustomer.TABLE_CUSTOMER_ADDRESS]), proxy: \(item[tableCustomer.TABLE_CUSTOMER_PROXY]), note: \(item[tableCustomer.TABLE_CUSTOMER_NOTE]), delete: \(item[tableCustomer.TABLE_CUSTOMER_DELETE])")
            let data = BADataCustomer()
            data.id = item[tableCustomer.TABLE_CUSTOMER_ID]
            data.name = item[tableCustomer.TABLE_CUSTOMER_NAME]
            data.telephone = item[tableCustomer.TABLE_CUSTOMER_TELEPHONE]
            data.address = item[tableCustomer.TABLE_CUSTOMER_ADDRESS]
            data.note = item[tableCustomer.TABLE_CUSTOMER_NOTE]
            if item[tableCustomer.TABLE_CUSTOMER_PROXY] == 1 {
                data.proxy = true
            }
            else {
                data.proxy = false
            }
            if item[tableCustomer.TABLE_CUSTOMER_DELETE] == 1 {
                data.delete = true
            }
            else {
                data.delete = false
            }
            array.append(data)
        }
        return array
    }
    
    // 更新
    func updateItem(_ customerID: Int64, _ name: String, _ telephone: String, _ address: String, _ proxy: Int64, _ note: String, _ delete: Int64) -> Bool {
        let item = tableCustomer.TABLE_CUSTOMER.filter(tableCustomer.TABLE_CUSTOMER_ID == customerID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableCustomer.TABLE_CUSTOMER_NAME <- name,  tableCustomer.TABLE_CUSTOMER_TELEPHONE <- telephone,  tableCustomer.TABLE_CUSTOMER_ADDRESS <- address,  tableCustomer.TABLE_CUSTOMER_PROXY <- proxy,  tableCustomer.TABLE_CUSTOMER_NOTE <- note,  tableCustomer.TABLE_CUSTOMER_DELETE <- delete)) > 0 {
                print("客户 \(name) 更新成功")
                return true
            } else {
                print("没有发现 客户\(name)")
                return false
            }
        } catch {
            print("客户\(name) 更新失败：\(error)")
            return false
        }
    }
    
    
    // 删除
    func deleteItem(customerID: Int64) -> Bool {
        let item = tableCustomer.TABLE_CUSTOMER.filter(tableCustomer.TABLE_CUSTOMER_ID == customerID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableCustomer.TABLE_CUSTOMER_DELETE <- 1)) > 0 {
                print("客户ID:\(customerID) 删除成功")
                return true
            } else {
                print("没有发现 客户ID:\(customerID)")
                return false
            }
        } catch {
            print("客户ID:\(customerID) 删除失败：\(error)")
            return false
        }
    }
    
}
