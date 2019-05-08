//
//  Student.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation

class Student: People {
    var score : Float
    
    override init() {
        score = 98.0
        super.init()
    }
}
