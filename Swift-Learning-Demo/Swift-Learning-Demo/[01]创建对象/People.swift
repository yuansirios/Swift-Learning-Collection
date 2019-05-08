//
//  People.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation

class People{
    // 变量值
    var name : String
    var age  : Int
    
    // 初始化方法
    init() {
        name = "yuan"
        age  = 10
    }
    
    // 类方法
    class func maxAge() -> Int{
        return 100
    }
    
    class func minAge() -> Int{
        return 0
    }
    
    // 普通方法
    func info(name:String,age:Int) -> String {
        return "name:\(name) + age:\(age)"
    }
    
    func subInfo() -> String {
        return "name:\(name) + age:\(age)"
    }
}
