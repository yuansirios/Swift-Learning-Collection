//
//  ArraySolution.swift
//  Swift-Learning-Demo
//
//  Created by yuan xiaodong on 2020/12/22.
//  Copyright © 2020 yuan. All rights reserved.
//

import Foundation

class ArraySolution {
    init() {
        
    }
    
    // MARK: - *********** 【1】两数之和 难度:简单 ***********
    /*
     给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
     示例:
     给定 nums = [2, 7, 11, 15], target = 9
     因为 nums[0] + nums[1] = 2 + 7 = 9
     所以返回 [0, 1]
     */
    //时间复杂度是 O(n)
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int:Int]()
        for i in 0..<nums.count {
            let another = target - nums[i]
            if dic.keys.contains(another) {
                return [dic[another]! as Int,i]
            }
            dic[nums[i]] = i
        }
        return [];
    }
    
    // MARK: - *********** 【26】删除排序数组中的重复项 难度:简单 ***********
    /*
     给定一个排序数组，你需要在 原地 删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
     不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。

     示例 1:
     给定数组 nums = [1,1,2],
     函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。
     你不需要考虑数组中超出新长度后面的元素。
     
     示例 2:
     给定 nums = [0,0,1,1,1,2,2,3,3,4],
     函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。
     你不需要考虑数组中超出新长度后面的元素。
     */
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var length : Int = 0
        if nums.count > 0{
            length = 1
            var prev : Int = nums[0]
            var currentIndex = 1
            var index : Int = 1
            while index < nums.count {
                while(index < nums.count && nums[index] == prev){
                    index += 1
                }
                if index < nums.count && nums[index] != prev {
                    nums[currentIndex] = nums[index]
                    prev = nums[currentIndex]
                    length += 1
                    currentIndex += 1
                }

            }
        }
        return length
    }
    
    // MARK: - *********** 【27】移除元素 难度:简单 ***********
    /*
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

     示例 1:
     给定 nums = [3,2,2,3], val = 3,
     函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。
     你不需要考虑数组中超出新长度后面的元素。
     
     示例 2:
     给定 nums = [0,1,2,2,3,0,4,2], val = 2,
     函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。
     注意这五个元素可为任意顺序。

     你不需要考虑数组中超出新长度后面的元素。
     */
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0, j = nums.count - 1
        while i <= j {
            if nums[i] == val {
               //根据数组索引互换两个元素
                nums.swapAt(i, j)
                j -= 1
            } else {
                i += 1
            }
        }
        return j + 1
    }
}
