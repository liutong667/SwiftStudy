//
//  main.swift
//  SwiftSwordOffer
//
//  Created by liutong on 2021/7/26.
//

import Foundation

/* 03. 找出数组中重复的数字。
 
在一个长度为 n 的数组 nums 里的所有数字都在0～n-1的范围内。
数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字
 
输入：[2, 3, 1, 0, 2, 5, 3]
输出：2 或 3
 */
func test01() {
    print("-------------test01-------------------")
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var numDict: [Int:Int] = [:]
        for value in nums {
            if numDict[value] != nil {
                return value
            } else {
                numDict[value] = 1
            }
        }
        return -1
    }
    print(findRepeatNumber([2, 3, 1, 0, 2, 5, 3]))
}
test01()

/* 04. 二维数组中的查找
 
 在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。
 请完成一个高效的函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
 
 现有矩阵 matrix 如下：
 [
   [1,   4,  7, 11, 15],
   [2,   5,  8, 12, 19],
   [3,   6,  9, 16, 22],
   [10, 13, 14, 17, 24],
   [18, 21, 23, 26, 30]
 ]
 给定 target = 5，返回 true。
 给定 target = 20，返回 false。

 */
func test02() {
    print("-------------test02-------------------")
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        let rows = matrix.count
        let columns = matrix[0].count
        if rows == 0 || columns == 0 {
            return false
        }
        var row = 0, column = 0
        while row < rows && column < columns {
            let value = matrix[row][column]
            if target == value {
                return true
            } else if (target < value) {
                return false
            } else {
                if row < rows - 1 {
                    row += 1
                } else if column < columns - 1 {
                    column += 1
                }
            }
        }
        return false
    }
    let arr =  [
        [1,   4,  7, 11, 15],
        [2,   5,  8, 12, 19],
        [3,   6,  9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ]
    print(222)
    print(findNumberIn2DArray(arr, 12))
    print(111)
}
test02()


///
func test03() {
    print("-------------test03-------------------")

}
test03()

///
func test04() {
    print("-------------test04-------------------")

}
test04()

///
func test05() {
    print("-------------test05-------------------")

}
test05()

///
func test06() {
    print("-------------test06-------------------")

}
test06()


///
func test07() {
    print("-------------test07-------------------")

}
test07()

///
func test08() {
    print("-------------test08-------------------")

}
test08()


///
func test09() {
    print("-------------test09-------------------")

}
test09()

///
func test10() {
    print("-------------test10-------------------")

}
test10()

///
func test11() {
    print("-------------test11-------------------")

}
test11()

///
func test12() {
    print("-------------test12-------------------")

}
test12()

///
func test13() {
    print("-------------test13-------------------")

}
test13()

///
func test14() {
    print("-------------test14-------------------")

}
test14()







