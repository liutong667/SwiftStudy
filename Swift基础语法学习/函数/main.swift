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

/// 9、
func test09() {
    
}
func test10() {
    
}
//func test06() {
//
//}
//func test07() {
//
//}
//func test08() {
//
//}
//func test09() {
//
//}
//func test10() {
//
//}
//func test06() {
//
//}
//func test07() {
//
//}
//func test08() {
//
//}
//func test09() {
//
//}
//func test10() {
//
//}

test08()
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
