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
    /**
     给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

     如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

     您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

     示例：

     输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
     输出：7 -> 0 -> 8
     原因：342 + 465 = 807
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let newList = ListNode(0);
        var p = newList;
        var p1 = l1;
        var p2 = l2;
        var div = 0;
        while true {
            let val1 = p1 == nil ? 0 : p1!.val;
            let val2 = p2 == nil ? 0 : p2!.val;
            let value = (val1 + val2 + div) % 10;
            div = ((val1 + val2 + div) - value) / 10;
            p.val = value;
            if p1?.next == nil &&  p2?.next == nil && div == 0 {
                break
            } else {
                p.next = ListNode(0);
                p = p.next!;
                if p1 != nil {
                    p1 = p1?.next;
                }
                if p2 != nil {
                    p2 = p2?.next;
                }
            }
        }
        return newList;
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
    
    // MARK: - *********** 【15】三数之和 难度:中等 ***********
    /**
     给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

     注意：答案中不可以包含重复的三元组。

     示例：

     给定数组 nums = [-1, 0, 1, 2, -1, -4]，

     满足要求的三元组集合为：
     [
       [-1, 0, 1],
       [-1, -1, 2]
     ]
     解题思路 #
     用 map 提前计算好任意 2 个数字之和，保存起来，可以将时间复杂度降到 O(n^2)。这一题比较麻烦的一点在于，最后输出解的时候，要求输出不重复的解。数组中同一个数字可能出现多次，同一个数字也可能使用多次，但是最后输出解的时候，不能重复。例如 [-1，-1，2] 和 [2, -1, -1]、[-1, 2, -1] 这 3 个解是重复的，即使 -1 可能出现 100 次，每次使用的 -1 的数组下标都是不同的。

     这里就需要去重和排序了。map 记录每个数字出现的次数，然后对 map 的 key 数组进行排序，最后在这个排序以后的数组里面扫，找到另外 2 个数字能和自己组成 0 的组合。
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else { return [] }
        var solutions = [[Int]]();
        let sorted = nums.sorted() { $0 < $1 }
        let count = sorted.count
        var i = 0

        while (i < count - 2) {
            if (i == 0 || (i > 0 && sorted[i] != sorted[i - 1])) {
                var left = i + 1
                var right = count - 1
                let num = sorted[i]

                while (left < right) {
                    let currentSum = sorted[left] + sorted[right] + num

                    if (currentSum == 0) {
                        solutions.append([sorted[left], sorted[right], num])

                        while (left < right && sorted[left] == sorted[left + 1]) {
                            left += 1
                        }

                        while (left < right && sorted[right] == sorted[right - 1]) {
                            right -= 1
                        }
                        left += 1
                        right -= 1
                    } else if (currentSum < 0) {
                        left += 1
                    } else {
                        right -= 1
                    }
                }
            }
            i += 1
        }
        return solutions
    }
}


