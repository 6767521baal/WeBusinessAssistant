//
//  BADataBase.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/8.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation
import SQLite

class BADatabase {
    
    var db: Connection!
    
    let tableGoods = BAGoodsTable()
    let tableType = BATypeTable()
    let tableCustomer = BACustomerTable()
    
    private static let database = BADatabase()
    
    //对外提供创建单例对象的接口
    class func shareInstance() -> BADatabase {
        return database
    }
    
    private init() {
        
        let sqlFilePath = NSHomeDirectory() + "/Documents/db.sqlite3"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("与数据库建立连接 成功")
        } catch {
            print("与数据库建立连接 失败：\(error)")
        }
    }
    
    func createTables() {
        tableGoods.createTable()
        tableType.createTable()
        tableCustomer.createTable()
    }
}
