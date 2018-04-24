//
//  BADataObject.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/10.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation

class BADataGoods : NSObject {
    
    var id:Int64
    var name :String
    var typeString :String
    var typeInt64 :Int64
    var count :Int64
    var purchase :String
    var purchase_other :String
    var sell :String
    var proxy :String
    var note :String
    var delete :Bool
    
    override init()
    {
        id = -1
        name = ""
        typeString = ""
        typeInt64 = 0
        count = 0
        purchase = ""
        purchase_other = ""
        sell = ""
        proxy = ""
        note = ""
        delete = false
    }
    
}

class BADataType : NSObject {
    
    var id:Int64
    var name :String
    var delete :Bool
    
    override init()
    {
        id = -1
        name = ""
        delete = false
    }
    
}

class BADataObject: NSObject {
    
    // 持有的所有数据
    var dataGoods :[BADataGoods] = []
    var dataType :[BADataType] = []
    // 包含已删除的所有数据
    var allGoods :[BADataGoods] = []
    var allType :[BADataType] = []
    
    // 通过是否为nil区分是新增还是编辑，感觉有点蠢
    var editGood :BADataGoods? = nil
    var editType :BADataType? = nil
    
    private static let dataManager = BADataObject()
    
    //对外提供创建单例对象的接口
    class func shareInstance() -> BADataObject {
        return dataManager
    }
    
    private override init() {
        // 建表
        BADatabase.shareInstance().createTables()
        // 遍历表内容
        BADatabase.shareInstance().tableGoods.queryAllItems()
        BADatabase.shareInstance().tableType.queryAllItems()
    }
    
    /*
     Good相关操作
     */
    func addGoodData(data: BADataGoods) -> Bool {
        for type in dataType {
            if type.name == data.typeString {
                data.typeInt64 = type.id
            }
        }
        
        var delete :Int64 = 0
        if data.delete {
            delete = 1
        }
        
        return BADatabase.shareInstance().tableGoods.insertItem(name: data.name, type: data.typeInt64, count : data.count, purchase: data.purchase, purchase_other: data.purchase_other, sell: data.sell, proxy: data.proxy, note: data.note, delete: delete)
    }
    
    func updateGoodData(goodID :Int64, name: String, type: String, count: Int64, purchase: String, purchase_other: String, sell: String, proxy: String, note: String, delete: Bool) -> Bool {
        var typeInt: Int64 = 1
        for data in dataType {
            if data.name == type {
                typeInt = data.id
            }
        }
        var deleteInt :Int64 = 0
        if delete {
            deleteInt = 1
        }
        return BADatabase.shareInstance().tableGoods.updateItem(goodID, name, typeInt, count, purchase, purchase_other, sell, proxy, note, deleteInt)
    }
    
    func getGoodData(goodID :Int64) -> BADataGoods? {
        refreshGoodsData()
        for good in dataGoods {
            if good.id == goodID {
                return good
            }
        }
        return nil
    }
    
    func getAllGoodsData() -> [BADataGoods] {
        refreshGoodsData()
        return dataGoods
    }
    
    func refreshGoodsData(includeDelete :Bool = false) {
        let data = BADatabase.shareInstance().tableGoods.getAllItems(includeDelete: includeDelete)
        if data.count > 0
        {
            // 处理商品类型
            print("共计商品类型\(allType.count)个")
            for good in data {
                for type in allType {
                    if good.typeInt64 == type.id {
                        good.typeString = type.name
                        break
                    }
                }
            }
            if includeDelete {
                allGoods = data
                dataGoods.removeAll()
                for good in data {
                    if !good.delete {
                        dataGoods.append(good)
                    }
                }
            }
            else {
                dataGoods = data
            }
        }
    }
    
    func deleteGoodsData(goodID :Int64) -> Bool {
        return BADatabase.shareInstance().tableGoods.deleteItem(goodID: goodID)
    }
    
    /*
   Type相关操作
     */
    func addTypeData(data: BADataType) -> Bool {
        var delete :Int64 = 0
        if data.delete {
            delete = 1
        }
        return BADatabase.shareInstance().tableType.insertItem(name: data.name, delete: delete)
    }
    
    func updateTypeData(typeID :Int64, name: String, delete: Bool) -> Bool {
        var deleteInt :Int64 = 0
        if delete {
            deleteInt = 1
        }
        return BADatabase.shareInstance().tableType.updateItem(typeID, name, deleteInt)
    }
    
    func getTypeData(typeID :Int64) -> BADataType? {
        refreshTypeData()
        for type in dataType {
            if type.id == typeID {
                return type
            }
        }
        return nil
    }
    
    func getAllTypeData(refreshDelete :Bool = false) -> [BADataType] {
        refreshTypeData(includeDelete: refreshDelete)
        return dataType
    }
    
    func refreshTypeData(includeDelete :Bool = false) {
        let data = BADatabase.shareInstance().tableType.getAllItems(includeDelete: includeDelete)
        if data.count > 0
        {
            if includeDelete {
                allType = data
                dataType.removeAll()
                for type in data {
                    if !type.delete {
                        dataType.append(type)
                    }
                }
            }
            else {
                dataType = data
            }
        }
    }
    
    func deleteTypeData(typeID :Int64) -> Bool {
        return BADatabase.shareInstance().tableType.deleteItem(typeID: typeID)
    }
    
}
