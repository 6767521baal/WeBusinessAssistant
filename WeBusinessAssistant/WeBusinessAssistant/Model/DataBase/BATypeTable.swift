//
//  BATypeTable.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/23.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation
import SQLite

struct DB_GOOD_TYPE {
    // 表名
    let TABLE_GOOD_TYPE = Table("table_good_type")
    // 列名及类型
    let TABLE_TYPE_ID = Expression<Int64>("type_id")
    let TABLE_TYPE_NAME = Expression<String>("type_name")
    let TABLE_TYPE_DELETE = Expression<Int64>("type_is_delete")
}

class BATypeTable {
    
    let tableType = DB_GOOD_TYPE()
    
    // 建表
    func createTable() -> Void {
        do { // 创建表
            try BADatabase.shareInstance().db.run(tableType.TABLE_GOOD_TYPE.create { table in
                table.column(tableType.TABLE_TYPE_ID, primaryKey: .autoincrement)
                table.column(tableType.TABLE_TYPE_NAME)
                table.column(tableType.TABLE_TYPE_DELETE)
            })
            print("创建表 table_good_type 成功")
            // 创建成功后加入默认类型
            // 0其他1母婴2个护美妆3营养保健4钟表5服装6轻奢7食品8家居9电子产品
            if ( insertItem(name: "其他", delete: 0) &&
            insertItem(name: "母婴", delete: 0) &&
            insertItem(name: "个护美妆", delete: 0) &&
            insertItem(name: "营养保健", delete: 0) &&
            insertItem(name: "钟表", delete: 0) &&
            insertItem(name: "服装", delete: 0) &&
            insertItem(name: "轻奢", delete: 0) &&
            insertItem(name: "食品", delete: 0) &&
            insertItem(name: "家居", delete: 0) &&
                insertItem(name: "电子产品", delete: 0)) {
                print("插入默认类型成功")
            }
            else {
                print("插入默认类型失败！")
            }
        } catch {
            print("创建表 table_good_type 失败：\(error)")
        }
    }
    
    // 插入
    func insertItem(name: String, delete: Int64) -> Bool {
        let insert = tableType.TABLE_GOOD_TYPE.insert(tableType.TABLE_TYPE_NAME <- name,  tableType.TABLE_TYPE_DELETE <- delete)
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
        for item in (try! BADatabase.shareInstance().db.prepare(tableType.TABLE_GOOD_TYPE)) {
            print("类型 遍历 ———— id: \(item[tableType.TABLE_TYPE_ID]), name: \(item[tableType.TABLE_TYPE_NAME]), delete: \(item[tableType.TABLE_TYPE_DELETE])")
        }
    }
    
    // 读取
    func readItem(name: String) -> [BADataType] {
        var array :[BADataType] = []
        for item in try! BADatabase.shareInstance().db.prepare(tableType.TABLE_GOOD_TYPE.filter(tableType.TABLE_TYPE_NAME == name)) {
            print("类型 读取 ———— id: \(item[tableType.TABLE_TYPE_ID]), name: \(item[tableType.TABLE_TYPE_NAME]), delete: \(item[tableType.TABLE_TYPE_DELETE])")
            let data = BADataType()
            data.name = item[tableType.TABLE_TYPE_NAME]
            if item[tableType.TABLE_TYPE_DELETE] == 1 {
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
    func getAllItems(includeDelete :Bool = false) -> [BADataType] {
        var array :[BADataType] = []
        for item in (try! BADatabase.shareInstance().db.prepare(tableType.TABLE_GOOD_TYPE)) {
            print("获取全部类型 ———— id: \(item[tableType.TABLE_TYPE_ID]), name: \(item[tableType.TABLE_TYPE_NAME]), delete: \(item[tableType.TABLE_TYPE_DELETE])")
            let data = BADataType()
            data.id = item[tableType.TABLE_TYPE_ID]
            data.name = item[tableType.TABLE_TYPE_NAME]
            if item[tableType.TABLE_TYPE_DELETE] == 1 {
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
    func updateItem(_ typeID: Int64, _ name: String, _ delete: Int64) -> Bool {
        let item = tableType.TABLE_GOOD_TYPE.filter(tableType.TABLE_TYPE_ID == typeID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableType.TABLE_TYPE_NAME <- name, tableType.TABLE_TYPE_DELETE <- delete)) > 0 {
                print("类型\(name) 更新成功")
                return true
            } else {
                print("没有发现 类型\(name)")
                return false
            }
        } catch {
            print("类型\(name) 更新失败：\(error)")
            return false
        }
    }
    
    
    // 删除
    func deleteItem(typeID: Int64) -> Bool {
        let item = tableType.TABLE_GOOD_TYPE.filter(tableType.TABLE_TYPE_ID == typeID)
        do {
            if try BADatabase.shareInstance().db.run(item.update(tableType.TABLE_TYPE_DELETE <- 1)) > 0 {
                print("商品ID:\(typeID) 删除成功")
                return true
            } else {
                print("没有发现 商品ID:\(typeID)")
                return false
            }
        } catch {
            print("商品ID:\(typeID) 删除失败：\(error)")
            return false
        }
    }
}
