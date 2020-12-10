//
//  Solution.swift
//  Swift-Learning-Demo
//
//  Created by yuan xiaodong on 2020/12/5.
//  Copyright © 2020 yuan. All rights reserved.
//

import Foundation

class Solution {
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
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var intArr = [Int]();
        for i in 0..<nums.count {
            for j in (i+1)..<nums.count {
                if (nums[i] + nums[j] == target){
                    intArr = [i,j];
                }
            }
        }
        return intArr;
    }
    
    //时间复杂度是 O(n)
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
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
     
    // MARK: - *********** 【11】盛最多水的容器 难度:中等 ***********
    /**
     给你 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

     说明：你不能倾斜容器。
     输入：[1,8,6,2,5,4,8,3,7]
     输出：49
     解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
     
     示例 2：
     输入：height = [1,1]
     输出：1
     
     示例 3：
     输入：height = [4,3,2,1,4]
     输出：16
     
     示例 4：
     输入：height = [1,2,1]
     输出：2
      
     提示：

     n = height.length
     2 <= n <= 3 * 104
     0 <= height[i] <= 3 * 104
     
     */
    func maxArea(_ height: [Int]) -> Int {
        var max = 0
        var start = 0
        var end = height.count - 1
        
        while start < end {
            let width = end - start
            var high = 0
            let startH = height[start]
            let endH = height[end]
            if  startH < endH {
                high = height[start]
                start = start + 1
            }else{
                high = height[end]
                end = end - 1
            }
            let temp = width * high
            if temp > max {
                max = temp
            }
        }
        return max
    }
}


