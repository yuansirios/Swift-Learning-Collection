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
     
    // MARK: - *********** 【2】两数相加 难度:中等 ***********
    /*
     给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

     如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

     您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

     示例：

     输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
     输出：7 -> 0 -> 8
     原因：342 + 465 = 807
     */
 
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return ListNode()
    }
}


