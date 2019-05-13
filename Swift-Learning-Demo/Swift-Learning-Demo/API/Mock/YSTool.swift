//
//  Mock.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/8.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation

//TODO:文件读内容
@inline(__always) func dataForJson(fileName:String) -> NSData {
    let filePath = Bundle.main.path(forResource: fileName, ofType: "")
    let jsonData = NSData.init(contentsOfFile: filePath!)
    return jsonData!
}

//MARK: - JSON 和 字典互转

//JSONString转换为字典
@inline(__always) func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}

//字典转换为JSONString
@inline(__always) func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

//MARK: - JSON 和 数组互转

//JSONString转换为数组
@inline(__always) func getArrayFromJSONString(jsonString:String) ->NSArray{
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if array != nil {
        return array as! NSArray
    }
    return array as! NSArray
    
}

//数组转JSONString
@inline(__always) func getJSONStringFromArray(array:NSArray) -> String {
    
    if (!JSONSerialization.isValidJSONObject(array)) {
        print("无法解析出JSONString")
        return ""
    }
    
    let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}


