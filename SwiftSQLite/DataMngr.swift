//
//  DataMngr.swift
//  SwiftSQLite
//
//  Created by Aizawa Takashi on 2015/04/21.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import Foundation

class DataMngr{
    let TABLE_NAME = "swiftSQLTest"
    

    init(){
        if !self.isExistDataBase() {
            if !self.createTable() {
                println("error: cannot create Table")
            }
        }
        
    }
    class var sharedInstance:DataMngr {
        struct Static{
            static let instance:DataMngr = DataMngr()
        }
        return Static.instance
    }
    
    func isExistDataBase()->Bool {
        let (tables, error) = SwiftData.existingTables()
        var result:Bool = false
        if( contains(tables, TABLE_NAME) ) {
            result = true
        }else{
            result = false
        }
        return result
    }

    func createTable()->Bool {
        var result:Bool = false
        if let error = SwiftData.createTable(TABLE_NAME, withColumnNamesAndTypes: ["date":SwiftData.DataType.DateVal, "weightMorning":SwiftData.DataType.DoubleVal, "weightEvening":SwiftData.DataType.DoubleVal, "bodyFatPercentageMorning":SwiftData.DataType.DoubleVal, "bodyFatPercentageEvening":SwiftData.DataType.DoubleVal]) {
            result = false
        }else{
            result = true
        }
        return result
    }
    
    func add(date:NSDate)->Bool {
        var result:Bool = false
        let sql = "INSERT INTO "+TABLE_NAME+" (date) VALUES (?)"
        if let error = SwiftData.executeChange(sql, withArgs: [date]) {
            let message = SwiftData.errorMessageForCode(error)
            println(message)
        }else{
            result = true
        }
        return result
    }
    
    func update(datas:Dictionary<String,Any>, targetDate date:NSDate)->Bool {
        var result:Bool = false
        var sql = "UPDATE "+TABLE_NAME+" set "
        let keyArray = Array(datas.keys)
        for key in keyArray {
            sql += key+" = ? ,"
        }
        var startIndex:String.Index
        var endIndex:String.Index
        var len = count(sql)
        startIndex = advance(sql.startIndex,0)
        endIndex = advance(sql.startIndex,len-2)
        var newSql = sql.substringToIndex(endIndex)
        newSql += " where date = ?"
        let values: Array = Array(datas.values)
        var args:[AnyObject] = []
        for value in values {
            args.append(value as! AnyObject)
        }
        args.append(date)
        if let error = SwiftData.executeChange(newSql, withArgs: args) {
            let message = SwiftData.errorMessageForCode(error)
            println(message)
        }else{
            result = true
        }
        return result
    }
    
    func selectAll()->[Dictionary<String,Any>] {
        let sql = "select * from "+TABLE_NAME+" order by date asc;"
        var results:[Dictionary<String,Any>] = []
        let (fetchDatas,error) = SwiftData.executeQuery(sql)
        if error != nil {
            let message = SwiftData.errorMessageForCode(error!)
            println(message)
        }else{
            for row in fetchDatas {
                let date:NSDate? = row["date"]?.asDate()
                let weightMorning:Double? = row["weightMorning"]?.asDouble()
                let weightEvening:Double? = row["weightEvening"]?.asDouble()
                let bodyFatPercentageMorning:Double? = row["bodyFatPercentageMorning"]?.asDouble()
                let bodyFatPercentageEvening:Double? = row["bodyFatPercentageEvening"]?.asDouble()
                results.append(["date":date, "weightMorning":weightMorning, "weightEvening":weightEvening, "bodyFatPercentageMorning":bodyFatPercentageMorning, "bodyFatPercentageEvening":bodyFatPercentageEvening])
            }
        }
        return results
    }
}