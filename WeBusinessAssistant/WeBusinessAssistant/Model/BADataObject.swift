//
//  BADataObject.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/10.
//  Copyright © 2018年 刘启. All rights reserved.
//

import Foundation

class BADataGoods : NSObject {
    
    var name :String
    var type :String
    var purchase :String
    var purchase_other :String
    var sell :String
    var proxy :String
    var note :String
    
    override init()
    {
        name = ""
        type = ""
        purchase = ""
        purchase_other = ""
        sell = ""
        proxy = ""
        note = ""
    }
    
}

class BADataObject: NSObject {
    
    var database : BADatabase!
    
    var dataGoods :[BADataGoods] = []
    
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
        return database.insertItemTableGoods(name: data.name, type: type, purchase: data.purchase, purchase_other: data.purchase_other, sell: data.sell, proxy: data.proxy, note: data.note)
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
    
    func deleteGoodsData(at :Int) {
        let type :Int
        switch dataGoods[at].type {
        case "保健品":
            type = 0
        case "美妆":
            type = 1
        case "婴儿用品":
            type = 2
        default:
            type = 3
        }
        database.deleteItemTableGoods(name: dataGoods[at].name, type: Int64(type))
        
        refreshGoodsData()
    }
    
}