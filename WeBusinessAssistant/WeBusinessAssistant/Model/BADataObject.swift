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
    var type :String
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
        type = ""
        count = 0
        purchase = ""
        purchase_other = ""
        sell = ""
        proxy = ""
        note = ""
        delete = false
    }
    
}

class BADataObject: NSObject {
    
    var database : BADatabase!
    
    var dataGoods :[BADataGoods] = []
    
    var dataGoodEdit :BADataGoods? = nil
    
    private static let dataManager = BADataObject()
    
    //对外提供创建单例对象的接口
    class func shareInstance() -> BADataObject {
        return dataManager
    }
    
    private override init() {
        // 建立数据库连接
        database = BADatabase()
        // 创建table_goods表
        database.createTableGoods()
        // 查询table_goods表内容
        database.queryTableGoods()
    }
    
    func addGoodData(data: BADataGoods) -> Bool {
        let type: Int64
        switch data.type {
        case "保健品":
            type = 0
        case "美妆":
            type = 1
        case "婴儿用品":
            type = 2
        default:
            type = 3
        }
        var delete :Int64 = 0
        if data.delete {
            delete = 1
        }
        return database.insertItemTableGoods(name: data.name, type: type, count : data.count, purchase: data.purchase, purchase_other: data.purchase_other, sell: data.sell, proxy: data.proxy, note: data.note, delete: delete)
    }
    
    func updateGoodData(goodID :Int64, name: String, type: String, count: Int64, purchase: String, purchase_other: String, sell: String, proxy: String, note: String, delete: Bool) -> Bool {
        let typeInt: Int64
        switch type {
        case "保健品":
            typeInt = 0
        case "美妆":
            typeInt = 1
        case "婴儿用品":
            typeInt = 2
        default:
            typeInt = 3
        }
        var deleteInt :Int64 = 0
        if delete {
            deleteInt = 1
        }
        return database.updateItemTableGood(goodID, name, typeInt, count, purchase, purchase_other, sell, proxy, note, deleteInt)
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
    
    func getGoodsData() -> [BADataGoods] {
        refreshGoodsData()
        return dataGoods
    }
    
    func refreshGoodsData() {
        let data = database.getAllTableGoods()
        if data.count > 0
        {
            dataGoods = data
        }
    }
    
    func deleteGoodsData(goodID :Int64) -> Bool {
        let bRet = database.deleteItemTableGoods(goodID: goodID)
        
        refreshGoodsData()
        
        return bRet
    }
    
}
