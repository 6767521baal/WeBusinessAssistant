//
//  BADataBase.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/8.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation
import SQLite

struct DB_GOODS {
    // 表名
    let TABLE_GOODS = Table("table_goods")
    // 列名及类型
    let TABLE_GOODS_ID = Expression<Int64>("goods_id")
    let TABLE_GOODS_NAME = Expression<String>("goods_name")
    let TABLE_GOODS_TYPE = Expression<Int64>("goods_type")
    let TABLE_GOODS_PURCHASE = Expression<String>("goods_purchase")
    let TABLE_GOODS_PURCHASE_OTHER = Expression<String>("goods_purchase_other")
    let TABLE_GOODS_SELL = Expression<String>("goods_sell")
    let TABLE_GOODS_PROXY = Expression<String>("goods_proxy")
    let TABLE_GOODS_NOTE = Expression<String>("goods_note")
}


class BADatabase {
    
    var db: Connection!
    
    let tableGoods = DB_GOODS()
    
    init() {
        connectDatabase()
    }
    
    // 与数据库建立连接
    func connectDatabase(filePath: String = "/Documents") -> Void {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("与数据库建立连接 成功")
        } catch {
            print("与数据库建立连接 失败：\(error)")
        }
    }
    
    // 建表
    func createTableGoods() -> Void {
        do { // 创建表
            try db.run(tableGoods.TABLE_GOODS.create { table in
                table.column(tableGoods.TABLE_GOODS_ID, primaryKey: .autoincrement)
                table.column(tableGoods.TABLE_GOODS_NAME)
                table.column(tableGoods.TABLE_GOODS_TYPE)
                table.column(tableGoods.TABLE_GOODS_PURCHASE)
                table.column(tableGoods.TABLE_GOODS_PURCHASE_OTHER)
                table.column(tableGoods.TABLE_GOODS_SELL)
                table.column(tableGoods.TABLE_GOODS_PROXY)
                table.column(tableGoods.TABLE_GOODS_NOTE)
            })
            print("创建表 TABLE_GOODS 成功")
        } catch {
            print("创建表 TABLE_GOODS 失败：\(error)")
        }
    }
    
    // 插入
    func insertItemTableGoods(name: String, type: Int64, purchase: String, purchase_other: String, sell: String, proxy: String, note: String) -> Bool {
        let insert = tableGoods.TABLE_GOODS.insert(tableGoods.TABLE_GOODS_NAME <- name, tableGoods.TABLE_GOODS_TYPE <- type, tableGoods.TABLE_GOODS_PURCHASE <- purchase, tableGoods.TABLE_GOODS_PURCHASE_OTHER <- purchase_other, tableGoods.TABLE_GOODS_SELL <- sell, tableGoods.TABLE_GOODS_PROXY <- proxy, tableGoods.TABLE_GOODS_NOTE <- note)
        do {
            let rowid = try db.run(insert)
            print("插入数据成功 id: \(rowid)")
            return true
        } catch {
            print("插入数据失败: \(error)")
            return false
        }
    }
    
    // 遍历
    func queryTableGoods() -> Void {
        for item in (try! db.prepare(tableGoods.TABLE_GOODS)) {
            print("商品 遍历 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE])")
        }
    }
    
    // 读取
    func readItemTableGoods(name: String, type: Int64) -> [BADataGoods] {
        var array :[BADataGoods] = []
        for item in try! db.prepare(tableGoods.TABLE_GOODS.filter(tableGoods.TABLE_GOODS_NAME == name)) {
            print("商品 读取 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE])")
            let data = BADataGoods()
            data.name = item[tableGoods.TABLE_GOODS_NAME]
            // TODO 从类型表中获取关联性
            switch item[tableGoods.TABLE_GOODS_TYPE]
            {
            case 0 :
                data.type = "保健品"
            case 1:
                data.type = "美妆"
            case 2:
                data.type = "婴儿用品"
            default :
                data.type = "其他"
            }
            data.purchase = item[tableGoods.TABLE_GOODS_PURCHASE]
            data.purchase_other = item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]
            data.sell = item[tableGoods.TABLE_GOODS_SELL]
            data.proxy = item[tableGoods.TABLE_GOODS_PROXY]
            data.note = item[tableGoods.TABLE_GOODS_NOTE]
            array.append(data)
        }
        return array
    }
    
    // 获取全部商品
    func getAllTableGoods() -> [BADataGoods] {
        var array :[BADataGoods] = []
        for item in (try! db.prepare(tableGoods.TABLE_GOODS)) {
            print("获取全部商品 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE])")
            let data = BADataGoods()
            data.name = item[tableGoods.TABLE_GOODS_NAME]
            // TODO 从类型表中获取关联性
            switch item[tableGoods.TABLE_GOODS_TYPE]
            {
            case 0 :
                data.type = "保健品"
            case 1:
                data.type = "美妆"
            case 2:
                data.type = "婴儿用品"
            default :
                data.type = "其他"
            }
            data.purchase = item[tableGoods.TABLE_GOODS_PURCHASE]
            data.purchase_other = item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]
            data.sell = item[tableGoods.TABLE_GOODS_SELL]
            data.proxy = item[tableGoods.TABLE_GOODS_PROXY]
            data.note = item[tableGoods.TABLE_GOODS_NOTE]
            array.append(data)
        }
        return array
    }
    /*
    // 更新
    func updateItemTableGoods(address: Int64, newName: String) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)
        do {
            if try db.run(item.update(TABLE_LAMP_NAME <- newName)) > 0 {
                print("灯光\(address) 更新成功")
            } else {
                print("没有发现 灯光条目 \(address)")
            }
        } catch {
            print("灯光\(address) 更新失败：\(error)")
        }
    }
    */
    
    // 删除
    func deleteItemTableGoods(name: String, type: Int64) -> Void {
        let item = tableGoods.TABLE_GOODS.filter(tableGoods.TABLE_GOODS_NAME == name && tableGoods.TABLE_GOODS_TYPE == type)
        do {
            if try db.run(item.delete()) > 0 {
                print("商品(\(name), \(type)) 删除成功")
            } else {
                print("没有发现 商品(\(name), \(type))")
            }
        } catch {
            print("商品(\(name), \(type)) 删除失败：\(error)")
        }
    }
}
