//
//  main.swift
//  闭包
//
//  Created by liutong on 2021/7/11.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 闭包表达式（Closure Expression）：在swift中，可以通过func定义一个函数，也可以通过闭包表达式定义一个函数
/*  闭包表达式格式如下：
     {
        (参数列表） -> 返回值类型  in
        函数体代码
     }
 */
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
}
test01()

/// 闭包表达式的简写
func test02() {
    print("-------------test02-------------------")
    func exec(v1: Int, v2: Int, fn:(Int, Int)->Int) {
        print(fn(v1,v2))
    }
    /// 作为函数参数几种省略写法
    // 1、正常写法
    exec(v1: 10, v2: 20, fn: {
        (v1: Int, v2: Int) -> Int in return v1 + v2
    })
    // 2、可省略参数类型
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in return v1 + v2
    })
    // 3、函数体是单个表达式，可省略return
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in v1 + v2
    })
    // 4、省略参数，用$0、$1...代替
    exec(v1: 10, v2: 20, fn: { $0 + $1 })
    // 5、省略参数
    exec(v1: 10, v2: 20, fn: + )

}
test02()

/// 尾随闭包
/// 如果一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数的连续性
func test03() {
    print("-------------test03-------------------")
    func exec(v1: Int, v2: Int, fn:(Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    /// 1、尾随闭包是一个被书写在函数调用括号外面的闭包表达式
    exec(v1: 10, v2: 20) {
        (v1: Int, v2: Int) -> Int in v1 + v2
    }
    exec(v1: 10, v2: 20) {
        $0 + $1
    }
    func exec2(fn:(Int, Int) -> Int) {
        print(fn(1,2))
    }
    /// 2、如果函数的唯一实参是 闭包表达式，而且使用了尾随闭包的语法，那就不需要在函数名后边写（）
    exec2 { v1, v2 in
        v1 + v2
    }
    exec2 { $0 + $1 }
}
test03()

/// 示例：数组排序
func test04() {
    print("-------------test04-------------------")
    var nums = [1,2,3,9,8,6,5]
    nums.sort()
    print("1----\(nums)")
    
    // func sort(by areInIncreasingOrder: (Element, Element) -> Bool)
    func cmp(v1: Int, v2: Int) -> Bool {
        v1 > v2
    }
    nums.sort(by: cmp(v1:v2:))
    print("2----\(nums)")

    /// 闭包表达式
    nums.sort(by: {
        (v1: Int, v2: Int) -> Bool in
        return v1 < v2
    })
    print("3----\(nums)")
    
    nums.sort(by: {
        v1, v2 in return v1 > v2
    })
    print("4----\(nums)")

    nums.sort(by: {
        v1, v2 in v1 < v2
    })
    print("5----\(nums)")
    
    nums.sort(by: {
        $0 > $1
    })
    print("6----\(nums)")
    
    nums.sort(by: <)
    print("7----\(nums)")
    
    /// 尾随闭包
    nums.sort { v1, v2 in  v1 > v2}
    print("8----\(nums)")
    
    nums.sort() { $0 < $1 }
    print("9----\(nums)")

    nums.sort { $0 > $1 }
    print("10----\(nums)")
}
test04()

/// 忽略参数： swift中忽略参数一般使用 _
func test04_1() {
    print("-------------test04_1-------------------")
    func exec(fn:(Int, Int) -> Int) {
        print(fn(1,2))
    }
    exec { _, v2 in
        10 + v2
    }
}
test04_1()


/// 闭包（Closure）
/*
    一个函数和它所捕获的变量\常量环境组合起来，称为闭包
    - 一般指定义在函数内部的函数
    - 一般它捕获的是最外层函数的局部变量\常量
 */

func test05() {
    print("-------------test05-------------------")
    typealias Fn = (Int) -> Int
    /// 以下三个函数功能一样
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus(_:)
    }
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
    let fn1 = getFn()
    let fn2 = getFn()
    print(fn1(1)) // 1
    print(fn1(3)) // 4
    print(fn1(5)) // 9
    print(fn2(2)) // 2
    print(fn2(4)) // 6
    print(fn2(6)) // 12
}
test05()

/// 闭包功能的等价转换
/*
 即：可以把闭包想象成是一个类的实例对象
- 内存在堆空间
- 捕获的局部变量\常量就是对象的成员（存储属性）
- 组成闭包的函数就是类内部定义的方法
注意：实际上，闭包每捕获一个变量，就会生成一个类似 实例对象的结构，来存储这个变量
 */
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

///注意：不过返回值是函数类型，那么参数的修饰要保持统一
func test07() {
    print("-------------test07-------------------")
    func add(_ num: Int) -> (inout Int) -> Void {
        func plus(v: inout Int) {
            v += num
        }
        return plus(v:)
    }
    func add2(_ num: Int) -> (inout Int) -> Void {
        return {
            $0 += num
//            v1 in v1 += num
        }
    }
    
    var tempNum = 1
    add(1)(&tempNum)
    print(tempNum)
    
    let plusOne = add2(1)
    plusOne(&tempNum)
    plusOne(&tempNum)
    print(tempNum)
}
test07()

/// 自动闭包
func test08() {
    print("-------------test08-------------------")
    func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
        return v1 > 0 ? v1 : v2
    }
    print(getFirstPositive(10, 20)) // 10
    print(getFirstPositive(0, 20)) //20
    print(getFirstPositive(-4, 20)) //20
    
    func getFirstPositive2(_ v1: Int, _ v2:()->Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    getFirstPositive2(10) {
        20
    }
    
    func getFirstPositive3(_ v1: Int, _ v2: @autoclosure ()->Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    getFirstPositive3(10, 20)
    
    /*
        @autoclosure会自动将 20 封装成闭包 {20}
        @autoclosure只支持 （）-? T 类型的参数
        @autoclosure并非只支持函数最后一个参数，也可以在函数中间位置的参数
        空合并运算符 ?? 使用了 @autoclosure技术
        有、无@autoclosure构成函数重载
     */
    // public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T
}
test08()
