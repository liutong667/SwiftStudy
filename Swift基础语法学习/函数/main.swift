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

// 4、函数的文档注释
func test04() {
    /// 求和（Summary）
    ///
    /// 两个数相加（Discussion）
    ///
    ///
    ///
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    sum(v1: 1, v2: 2)
}

/// 5、参数标签（Argument Label）
func test05() {
    
}
func test06() {
    
}
func test07() {
    
}
func test08() {
    
}
func test09() {
    
}
func test10() {
    
}

test03()
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
