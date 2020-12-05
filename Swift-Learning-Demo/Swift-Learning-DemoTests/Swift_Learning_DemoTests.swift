//
//  Swift_Learning_DemoTests.swift
//  Swift-Learning-DemoTests
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import XCTest
@testable import Swift_Learning_Demo

class Swift_Learning_DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSolution() {
        let nums = [2, 7, 11, 15]
        let taget = 9
        let arr = Solution().twoSum(nums, taget);
        print("twoSum的结果是\(arr)");
    }

    func testExample() {
        ObjTest().showInfo()
    }
    
    //MARK: - JOSN和数组互转
    func testJSONToArray() {
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        let arr = getArrayFromJSONString(jsonString: jsonStr! as String)
        print("json转数组 :\(arr)")
        
        let newJson = getJSONStringFromArray(array: arr as NSArray)
        print("数组转json :\(newJson)")
    }
    
    //MARK: - JOSN和字典互转
    func testJSONToDic() {
        let jsonData = dataForJson(fileName: "Dictionary.json")
        let jsonStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        let dic = getDictionaryFromJSONString(jsonString: jsonStr! as String)
        print("json转字典 :\(dic)")
        
        let newJson = getJSONStringFromDictionary(dictionary: dic as NSDictionary)
        print("字典转json :\(newJson)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
