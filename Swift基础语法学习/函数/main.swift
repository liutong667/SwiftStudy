//
//  main.swift
//  函数
//
//  Created by liutong on 2021/7/7.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

// 1、函数定义
func test01() {
    /// 形参默认是let类型
    func pi() -> Double {
        return 3.14
    }
    func sum(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
    /// 无返回值
    func sayHello1() {
        print("hello world")
    }
    func sayHello2() -> () {
        print("hello world")
    }
    func sayHello3() -> Void {
        print("hello world")
    }
}

// 2、隐式返回（Implicit Return）
func test02() {
    /// 如果整个函数体是一个第一表达式，那么函数会隐式返回这个表达式
    func sum(v1:Int, v2:Int) -> Int {
        v1+v2
    }
    let res = sum(v1: 10, v2: 20)
    print(res)
    
}

// 3、返回元组：实现函数多返回值
func test03() {
    func calculate(v1:Int, v2:Int) -> (sum:Int, difference:Int) {
        let sum = v1 + v2
        return (sum, v1 - v2)
    }
    let res = calculate(v1: 10, v2: 20)
    print(res.sum, res.difference)
    print(res)
}

// 4、函数的文档注释，格式如下
func test04() {
    /// 求和（Summary）
    ///
    /// 两个数相加（Discussion）
    /// - Parameter v1: 参数1
    /// - Parameter v2: 参数2
    /// - Returns: 两个数字和
    ///
    /// - Note: 批注
    ///
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    _ = sum(v1: 1, v2: 2)
}

/// 5、参数标签（Argument Label）
func test05() {
    /// time是参数标签
    func goToWork00(time: String) {
        print("go to work at \(time)")
    }
    goToWork00(time: "8:00")
    
    /// 参数标签可修改
    func goToWork01(at time: String) {
        print("go to work at \(time)")
    }
    goToWork01(at: "8:00")
    
    /// 可使用下划线_省略参数标签
    func goToWork02(_ time: String) {
        print("go to work at \(time)")
    }
    goToWork02("8:00")
}

/// 6、默认参数值（default parameter value）
func test06() {
    /// 参数可以有默认值
    func check(name: String = "Jack", age: Int, job: String = "teacher") {
        print("name = \(name), age = \(age), job = \(job)");
    }
    check(age: 25) // name = Jack, age = 25, job = teacher
    check(name: "Rose", age: 23) // name = Rose, age = 23, job = teacher
    /// c++的默认参数值：必须从右往左设置；swift拥有参数标签，所有没有此种限制
    /// 但在省略参数标签时，需要注意。eg：下面函数的middle不可以省略函数标签
    func test(_ start: Int = 1, middle: Int, _ end: Int = 3) {
        print(start, middle, end)
    }
//    test(middle: 6)
//    test(10, middle: 11, 12)
}

/// 7、可变参数（Variadic Parameter）
func test07() {
    func sum (_ numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
        }
        return total
    }
    print(sum(1,2,3))
    /// 一个函数最多只能有1个可变参数，跟在可变参数后面的参数不能省略参数标签
    func test(_ numbers: Int..., a: String, _ b: String) {
    }
    test(1,2,3, a: "a", "b")
    
}

/// 8、自带的print函数
func test08() {
    /*
     /// - Parameters:
     ///   - items: Zero or more items to print.
     ///   - separator: A string to print between each item. The default is a single
     ///     space (`" "`).
     ///   - terminator: The string to print after all items have been printed. The
     ///     default is a newline (`"\n"`).
     public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
     */
    print(1, 2, 3, 4, 5, separator: "")
    print(1, 2, 3, 4, 5, separator: "", terminator:"")
    /* print result
     12345
     12345Program ended with exit code: 0
     */
}

/// 9、输入输出参数（In-Out Parameter）
/*
 可以用inout关键字定义一个输入输出参数：可以在函数内部修改外部实参的值
 - 可变参数不能标记为inout
 - inout参数不能有默认值
 - inout参数只能出入可以被多次赋值的的
 - inout参数的本质是地址传递（引用传递）
 */
func test09() {
    func swapValue1(_ v1: inout Int, _ v2: inout Int) {
        let temp = v1
        v1 = v2
        v2 = temp
    }
    func swapValue2(_ v1: inout Int, _ v2: inout Int) {
        (v1, v2) = (v2, v1)
    }
    var num1 = 10, num2 = 20
    swapValue1(&num1, &num2)
    print(num1, num2)
    swapValue2(&num1, &num2)
    print(num1, num2)
    swap(&num1, &num2)
    print(num1, num2)
}
//test09()

/// 10、函数重载（Function Overload）
/*
    规则：1、函数名相同；2、参数个数不同 || 参数类型不同 || 参数标签不同；
    - 返回值类型与函数重载无关
    - 默认参数值和函数重载一起使用产生二义性
 */
func test10() {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    func sum(v1: Int, v2: Int, v3: Int) -> Int {
        v1 + v2 + v3
    }//
    func sum(v1: Int, v2: Double) -> Int {
        v1 + Int(v2)
    }//
    func sum(_ v1: Int, v2: Int) -> Int {
        v1 + v2
    }//
    func sum(a: Int, b: Int) -> Int {
        a + b
    }//
    print(sum(v1: 10, v2: 20))
    print(sum(v1: 10, v2: 20, v3: 30))
    print(sum(v1: 10, v2: 10.0))
    print(sum(10, v2: 20))
    print(sum(a: 10, b: 20))
}
//test10()


/// 11、内联函数
func test11() {
    @inline(never) func test1() {
        print("test1")
    }
    @inline(__always) func test2() {
        print("test2")
    }
}
test11()

/// 12、函数类型（Function Type）
func test12() {
    /// 每一个函数都是有类型的，函数类型由 函数形参、返回值类型 组成
    func test() {} // () -> () 或者 () -> Void
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    } // (Int, Int) -> Int
    let fn: (Int, Int) -> Int = sum
    let res = fn(10,20)
    print(res) //30, 调用时不需要参数标签
}
//test12()

/// 13、函数类型 作为 函数参数
func test13() {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    func difference(v1: Int, v2: Int) -> Int {
        v1 - v2
    }
    func calcAndPrint(_ fn: (Int, Int)->Int, _ v1: Int, _ v2: Int) {
        print("res = \(fn(v1, v2))")
    }
    calcAndPrint(sum(v1:v2:), 10, 20)
    calcAndPrint(difference(v1:v2:), 10, 20)
}
test13()

/// 14、函数类型作为函数返回值
func test14() {
    print("-------------test14-------------------")
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    func forward(_ forward: Bool) -> (Int) -> Int {
        forward ? next(_:) : previous(_:)
    }
    print(forward(true)(0))
    print(forward(false)(0))
}
test14()

/// 15、typealias 用来给类型起别名
///
func test15() {
    print("-------------test15-------------------")
    typealias Byte = Int8
    typealias Short = Int16
    typealias Long = Int64
    typealias Date = (year:Int, month:Int, day:Int)
    func test(_ date: Date) {
        print(date.year, "-", date.month, "-", date.day, separator: "")
    }
    test((2021, 7, 9))
    
}
test15()

/// 16、嵌套函数（Nested Function）
func test16() {
    print("-------------test16-------------------")
    func forward(_ forward: Bool) -> (Int) -> Int {
        func next(_ input: Int) -> Int {
            input + 1
        }
        func previous(_ input: Int) -> Int {
            input - 1
        }
        return forward ? next(_:) : previous(_:)
    }
    print(forward(true)(0))
    print(forward(false)(0))
}
test16()


///

class Person {
    func test() -> () {
        print("person")
    }
}

class Student: Person {
    override func test() {
        print("student")
    }
}

var p = Person()
var stu = Student()
