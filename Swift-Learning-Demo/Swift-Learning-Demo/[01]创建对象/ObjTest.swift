//
//  ObjTest.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/8.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation

class ObjTest{
    // TODO:初始化变量
    var people : People
    var student : Student = Student()
    
    // TODO:初始化
    init() {
        people      = People()
        people.name = "yuan"
        people.age  = 20
    }
    
    func showInfo(){
        print(people.subInfo())
    }
}
