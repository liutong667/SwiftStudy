//
//  main.swift
//  闭包
//
//  Created by liutong on 2021/7/11.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 闭包表达式
func test01() {
    print("-------------test01-------------------")
    func sum1(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    
    let sum2 = {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    };
    
    let res =
    {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    }(10, 20)
    
    print(sum1(10, 20))
    print(sum2(10, 20))
    print(res)
    
//    func calc(_ v1: Int, _ v2: Int, fn: (Int, Int) -> Int ) {
//        print(fn(v1, v2))
//    }
//    calc(10, 20) { v1, v2 in
//        v2 + v1
//    }
}
test01()

/// 闭包表达式简写
func test02() {
    print("-------------test02-------------------")
    func exec(v1: Int, v2: Int, fn:(Int, Int)->Int) {
        print(fn(v1,v2))
    }
    exec(v1: 10, v2: 20, fn: {
        (v1: Int, v2: Int) -> Int in return v1 + v2
    })
    exec(v1: 10, v2: 20) {
        v1, v2 in return  v1 + v2
    }
    exec(v1: 10, v2: 20) {
        v1, v2 in v1 + v2
    }
    exec(v1: 10, v2: 20, fn: { $0 + $1 })
    exec(v1: 10, v2: 20, fn: + )

}
test02()

/// 尾随闭包
func test03() {
    print("-------------test03-------------------")
    /// 一、
    func exec(v1: Int, v2: Int, fn:(Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    exec(v1: 10, v2: 20) {
        (v1: Int, v2: Int) -> Int in v1 + v2
    }
    exec(v1: 10, v2: 20) {
        $0 + $1
    }
    /// 二、
    func exec2(fn:(Int, Int) -> Int) {
        print(fn(1,2))
    }
    exec2 { v1, v2 in
        v1 + v2
    }
    exec2(fn: { $0 + $1})
    exec2 { $0 + $1 }
    
}
test03()

/// 数组排序
func test04() {
    print("-------------test04-------------------")
    var nums = [1,2,3,324,324,5,9,6]
    nums.sort()
    print(nums)
    
    func cmp(v1: Int, v2: Int) -> Bool {
        v1 > v2
    }
    nums.sort(by: cmp(v1:v2:))
    print(nums)

    nums.sort(by: {
        (v1: Int, v2: Int) -> Bool in
        return v1 < v2
    })
    print(nums)
    
    nums.sort(by: {
        v1, v2 in return v1 > v2
    })
    print(nums)

    nums.sort(by: {
        v1, v2 in v1 < v2
    })
    print(nums)
    
    nums.sort(by: {
        $0 > $1
    })
    print(nums)
    
    nums.sort(by: <)
    print(nums)
    
    nums.sort() { $0 > $1 }
    print(nums)

    nums.sort { $0 < $1 }
    print(nums)
}
test04()

/// 闭包
func test05() {
    print("-------------test05-------------------")
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus(_:)
    }
    let fn1 = getFn()
    let fn2 = getFn()
    print(fn1(1)) // 1
    print(fn1(3)) // 4
    print(fn1(5)) // 9
    print(fn2(2)) // 2
    print(fn2(4)) // 6
    print(fn2(6)) // 12
    
    func getFn2() -> Fn {
        var num = 0
        return {
            num += $0
            return num
        }
    }
    func getFn3() -> Fn {
        var num = 0
        return {
            (i: Int) -> Int in
            num += i
            return num
        }
    }
}
test05()

///
func test06() {
    print("-------------test06-------------------")
    class Closure {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
    }
    let cs1 = Closure()
    print(cs1.plus(1))
    print(cs1.plus(3))
    print(cs1.plus(5))
}
test06()

/////
//func test08() {
//    print("-------------test08-------------------")
//
//}
//test08()
