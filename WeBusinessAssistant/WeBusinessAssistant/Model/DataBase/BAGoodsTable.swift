//
//  BAGoodsTable.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/23.
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
    let TABLE_GOODS_COUNT = Expression<Int64>("goods_count")
    let TABLE_GOODS_PURCHASE = Expression<String>("goods_purchase")
    let TABLE_GOODS_PURCHASE_OTHER = Expression<String>("goods_purchase_other")
    let TABLE_GOODS_SELL = Expression<String>("goods_sell")
    let TABLE_GOODS_PROXY = Expression<String>("goods_proxy")
    let TABLE_GOODS_NOTE = Expression<String>("goods_note")
    let TABLE_GOODS_DELETE = Expression<Int64>("goods_is_delete")
}

class BAGoodsTable {
    
    let tableGoods = DB_GOODS()
    
    // 建表
    func createTable() -> Void {
        do { // 创建表
            try BADatabase.shareInstance().db.run(tableGoods.TABLE_GOODS.create { table in
                table.column(tableGoods.TABLE_GOODS_ID, primaryKey: .autoincrement)
                table.column(tableGoods.TABLE_GOODS_NAME)
                table.column(tableGoods.TABLE_GOODS_TYPE)
                table.column(tableGoods.TABLE_GOODS_COUNT)
                table.column(tableGoods.TABLE_GOODS_PURCHASE)
                table.column(tableGoods.TABLE_GOODS_PURCHASE_OTHER)
                table.column(tableGoods.TABLE_GOODS_SELL)
                table.column(tableGoods.TABLE_GOODS_PROXY)
                table.column(tableGoods.TABLE_GOODS_NOTE)
                table.column(tableGoods.TABLE_GOODS_DELETE)
            })
            print("创建表 table_goods 成功")
        } catch {
            print("创建表 table_goods 失败：\(error)")
        }
    }
    
    // 插入
    func insertItem(name: String, type: Int64, count: Int64, purchase: String, purchase_other: String, sell: String, proxy: String, note: String, delete: Int64) -> Bool {
        let insert = tableGoods.TABLE_GOODS.insert(tableGoods.TABLE_GOODS_NAME <- name, tableGoods.TABLE_GOODS_TYPE <- type, tableGoods.TABLE_GOODS_COUNT <- count, tableGoods.TABLE_GOODS_PURCHASE <- purchase, tableGoods.TABLE_GOODS_PURCHASE_OTHER <- purchase_other, tableGoods.TABLE_GOODS_SELL <- sell, tableGoods.TABLE_GOODS_PROXY <- proxy, tableGoods.TABLE_GOODS_NOTE <- note, tableGoods.TABLE_GOODS_DELETE <- delete)
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
        for item in (try! BADatabase.shareInstance().db.prepare(tableGoods.TABLE_GOODS)) {
            print("商品 遍历 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), count: \(item[tableGoods.TABLE_GOODS_COUNT]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE]), delete: \(item[tableGoods.TABLE_GOODS_DELETE])")
        }
    }
    
    // 读取
    func readItem(name: String, type: Int64) -> [BADataGoods] {
        var array :[BADataGoods] = []
        for item in try! BADatabase.shareInstance().db.prepare(tableGoods.TABLE_GOODS.filter(tableGoods.TABLE_GOODS_NAME == name)) {
            print("商品 读取 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), count: \(item[tableGoods.TABLE_GOODS_COUNT]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE]), delete: \(item[tableGoods.TABLE_GOODS_DELETE])")
            let data = BADataGoods()
            data.name = item[tableGoods.TABLE_GOODS_NAME]
            data.typeInt64 = item[tableGoods.TABLE_GOODS_TYPE]
            data.count = item[tableGoods.TABLE_GOODS_COUNT]
            data.purchase = item[tableGoods.TABLE_GOODS_PURCHASE]
            data.purchase_other = item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]
            data.sell = item[tableGoods.TABLE_GOODS_SELL]
            data.proxy = item[tableGoods.TABLE_GOODS_PROXY]
            data.note = item[tableGoods.TABLE_GOODS_NOTE]
            if item[tableGoods.TABLE_GOODS_DELETE] == 1 {
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
    func getAllItems(includeDelete :Bool = false) -> [BADataGoods] {
        var array :[BADataGoods] = []
        for item in (try! BADatabase.shareInstance().db.prepare(tableGoods.TABLE_GOODS)) {
            print("获取全部商品 ———— id: \(item[tableGoods.TABLE_GOODS_ID]), name: \(item[tableGoods.TABLE_GOODS_NAME]), type: \(item[tableGoods.TABLE_GOODS_TYPE]), count: \(item[tableGoods.TABLE_GOODS_COUNT]), purchase: \(item[tableGoods.TABLE_GOODS_PURCHASE]), purchase_other: \(item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]), sell: \(item[tableGoods.TABLE_GOODS_SELL]), proxy: \(item[tableGoods.TABLE_GOODS_PROXY]), note: \(item[tableGoods.TABLE_GOODS_NOTE]), delete: \(item[tableGoods.TABLE_GOODS_DELETE])")
            let data = BADataGoods()
            data.id = item[tableGoods.TABLE_GOODS_ID]
            data.name = item[tableGoods.TABLE_GOODS_NAME]
            data.typeInt64 = item[tableGoods.TABLE_GOODS_TYPE]
            data.count = item[tableGoods.TABLE_GOODS_COUNT]
            data.purchase = item[tableGoods.TABLE_GOODS_PURCHASE]
            data.purchase_other = item[tableGoods.TABLE_GOODS_PURCHASE_OTHER]
            data.sell = item[tableGoods.TABLE_GOODS_SELL]
            data.proxy = item[tableGoods.TABLE_GOODS_PROXY]
            data.note = item[tableGoods.TABLE_GOODS_NOTE]
            if item[tableGoods.TABLE_GOODS_DELETE] == 1 {
                data.delete = true
            }
            else {
                data.delete = false
            }
            if !data.delete || includeDelete {
                array.append(data)
            }
        }
        return array
    }
    
    // 更新
    func updateItem(_ goodID: Int64, _ name: String, _ type: Int64, _ count: Int64, _ purchase: String, _ purchase_other: String, _ sell: String, _ proxy: String, _ note: String, _ delete: Int64) -> Bool {
        let item = tableGoods.TABLE_GOODS.filter(tableGoods.TABLE_GOODS_ID == goodID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableGoods.TABLE_GOODS_NAME <- name, tableGoods.TABLE_GOODS_TYPE <- type, tableGoods.TABLE_GOODS_COUNT <- count, tableGoods.TABLE_GOODS_PURCHASE <- purchase, tableGoods.TABLE_GOODS_PURCHASE_OTHER <- purchase_other, tableGoods.TABLE_GOODS_SELL <- sell, tableGoods.TABLE_GOODS_PROXY <- proxy, tableGoods.TABLE_GOODS_NOTE <- note, tableGoods.TABLE_GOODS_DELETE <- delete)) > 0 {
                print("商品\(name) 更新成功")
                return true
            } else {
                print("没有发现 商品\(name)")
                return false
            }
        } catch {
            print("商品\(name) 更新失败：\(error)")
            return false
        }
    }
    
    
    // 删除
    func deleteItem(goodID: Int64) -> Bool {
        let item = tableGoods.TABLE_GOODS.filter(tableGoods.TABLE_GOODS_ID == goodID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableGoods.TABLE_GOODS_DELETE <- 1)) > 0 {
                print("商品ID:\(goodID) 删除成功")
                return true
            } else {
                print("没有发现 商品ID:\(goodID)")
                return false
            }
        } catch {
            print("商品ID:\(goodID) 删除失败：\(error)")
            return false
        }
    }
}


