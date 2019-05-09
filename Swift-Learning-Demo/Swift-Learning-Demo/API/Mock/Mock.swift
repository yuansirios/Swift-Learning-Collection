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
