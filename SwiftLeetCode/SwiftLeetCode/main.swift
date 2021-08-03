//
//  main.swift
//  SwiftLeetCode
//
//  Created by liutong on 2021/8/2.
//

import Foundation

print("Hello, World!")

/*
 题号：53.最大子序和
 出现频率：7
 难度：简单
 
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 
 输入: [-2,1,-3,4,-1,2,1,-5,4]
 输出: 6
 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 
 注意：1. result的初始值为第一个元素。
 */
func test01() {
    print("-------------test01-------------------")
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var result = nums[0]
        var sum = 0
        for i in nums {
            if sum > 0 {
                sum += i
            } else {
                sum = i
            }
            result = result > sum ? result : sum
        }
        return result
    }
    let arr = [-2,1,-3,4,-1,2,1,-5,4]
    print(maxSubArray(arr))
}
test01()

/*
 
 */
func test02() {
    print("-------------test02-------------------")

}
test02()

/*
 
 */
func test03() {
    print("-------------test03-------------------")

}
test03()

/*
 
 */
func test04() {
    print("-------------test04-------------------")

}
test04()

/*
 
 */
func test05() {
    print("-------------test05-------------------")

}
test05()

/*
 
 */
func test06() {
    print("-------------test06-------------------")

}
test06()


/*
 
 */
func test07() {
    print("-------------test07-------------------")

}
test07()

/*
 
 */
func test08() {
    print("-------------test08-------------------")

}
test08()


/*
 
 */
func test09() {
    print("-------------test09-------------------")

}
test09()

/*
 
 */
func test10() {
    print("-------------test10-------------------")

}
test10()

/*
 
 */
func test11() {
    print("-------------test11-------------------")

}
test11()

/*
 
 */
func test12() {
    print("-------------test12-------------------")

}
test12()

/*
 
 */
func test13() {
    print("-------------test13-------------------")

}
test13()

/*
 
 */
func test14() {
    print("-------------test14-------------------")

}
test14()


