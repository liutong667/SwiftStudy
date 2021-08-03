//
//  main.swift
//  泛型
//
//  Created by liutong on 2021/7/24.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 泛型（Generics）：泛型可以将类型参数化，提高代码复用率，减少代码量

/// eg1:
func test01() {
    print("-------------test01-------------------")
    func swap<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    var i1 = 10, i2 = 20
    swap(&i1, &i2)
    print("i1 = \(i1), i2 = \(i2)")
    
    var d1 = 10.0, d2 = 20.0
    swap(&d1, &d2)
    print("d1 = \(d1), d2 = \(d2)")
    
    struct Date {
        var year = 0, month = 0, day = 0
    }
    var dd1 = Date(year: 2021, month: 8, day: 1)
    var dd2 = Date(year: 2022, month: 8, day: 1)
    swap(&dd1, &dd2)
    print("dd1 = \(dd1), dd2 = \(dd2)")
    
    class DateClass {
        var year = 0
    }
    var tempDD1 = DateClass()
    var tempDD2 = DateClass();
    print(tempDD1, tempDD2)
    swap(&tempDD1, &tempDD2)
    print(tempDD1, tempDD2)
    
    /// 泛型函数赋值给变量
    func test<T1, T2>(_ t1: T1, _ t2: T2) {}
    var fn: (Int, Double) -> Void = test(_:_:)
    
}
test01()

/// eg2:
func test02() {
    print("-------------test02-------------------")
    class Stack<Element> {
        var elements = [Element]()
        func push(_ element: Element) -> Void {
            elements.append(element)
        }
        func pop() -> Element? {
            if elements.isEmpty {
                return nil
            }
            return elements.removeLast()
        }
        func top() -> Element? {
            elements.last
        }
        func size() -> Int {
            elements.count
        }
    }
    let stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(10)
    print(stack.top()!)
    stack.pop()
    stack.pop()
    print(stack.pop())
    print(stack.pop())
    print(stack.size())
    
    enum Score<T> {
        case point(T)
        case garde(String)
    }
    let scroe0 = Score<Int>.point(100)
    let scroe1 = Score.point(100)
    let scroe2 = Score.point(99.5)
    let scroe3 = Score<Int>.garde("A")
    
}
test02()

/// 关联类型（Associated Type）
/*
    关联类型的作用：给协议中用到的类型定义一个占位名称
    协议中可以拥有多个关联类型
 */

protocol Stackable03 {
    associatedtype E
    mutating func push(_ element: E)
    mutating func pop() -> E
    func top() -> E
    func size() -> Int
}

func test03() {
    print("-------------test03-------------------")
    class Stack<Element>: Stackable03 {
        typealias E = Element
        var elements = [E]()
        func push(_ element: E) {
            elements.append(element)
        }
        func pop() -> E {
            elements.removeLast()
        }
        func top() -> E {
            elements.last!
        }
        func size() -> Int {
            elements.count
        }
    }
    
    struct StringStack: Stackable03 {
        //给关联类型设定真实类型
        typealias E = String
        var elements = [String]()
        mutating func push(_ element: String) {
            elements.append(element)
        }
        mutating func pop() -> String {
            elements.removeLast()
        }
        func top() -> String {
            elements.last!
        }
        func size() -> Int {
            elements.count
        }
    }
    var ss = StringStack()
    ss.push("jack")
    ss.push("rose")
    print(ss)
}
test03()

/// 类型约束
protocol Runable04 {}
protocol Stackable04 {
    associatedtype Element: Equatable
}
func test04() {
    print("-------------test04-------------------")
    //1
    class Person {}
    func swapValues<T: Person & Runable04>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    //2
    class Stack<E: Equatable> : Stackable04 {
        typealias Element = E
    }
    func equal<S1: Stackable04, S2: Stackable04>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
        return false
    }
    var stack1 = Stack<Int>()
    var stack2 = Stack<Int>()
    var stack3 = Stack<String>()
    equal(stack1, stack2)
}
test04()

/// 协议类型使用注意：
protocol Runable05_0 {}
protocol Runable05_1 {
    associatedtype Speed
    var speed: Speed {get}
}
func test05() {
    print("-------------test05-------------------")
    class Person0: Runable05_0 {}
    class Car0: Runable05_0 {}
    func get0(_ type: Int) -> Runable05_0 {
        if type == 0 {
            return Person0()
        }
        return Car0()
    }
    let r1 = get0(0)
    let r2 = get0(1)
    print(r1, r2)
    
    class Person1: Runable05_1 {
        var speed: Double { 10.0 }
    }
    class Car1: Runable05_1 {
        var speed: Int { 100 }
    }
//    // 直接使用Runable05_1报错，Runable05_1有泛型需要关联说明
//    func get2(_ type: Int) -> Runable05_1 {
//
//    }
    // 解决1：使用泛型
    func get1<T: Runable05_1>(_ type: Int) -> T {
        if type == 0 {
            return Person1() as! T
        }
        return Car1() as! T
    }
    let rr1: Person1 = get1(0)
    let rr2: Car1 = get1(1)
    print(rr1, rr2)
    //解决2：不透明类型（Opaque Type），使用some关键字声明一个不透明类型，
    func get2(_ type: Int) -> some Runable05_1 {
        Car1()
    }
    //some限制只能返回一种类型
    func get2_1(_ type: Int) -> some Runable05_1 {
        if type == 0 {
//            return Person1()
        }
        return Car1()
    }
}
test05()

/// some除了用在返回值类型上，一般还可以用在属性类型上
protocol Runable06 {
    associatedtype Speed
}
func test06() {
    print("-------------test06-------------------")
    class Dog: Runable06 {
        typealias Speed = Double
    }
    class Person {
        var pet: some Runable06 {
            return Dog()
        }
    }
    
}
test06()


/// 可选项本质：是enum类型
/*
 public enum Optional<Wrapped> : ExpressibleByNilLiteral {
     /// The absence of a value.
     ///
     /// In code, the absence of a value is typically written using the `nil`
     /// literal rather than the explicit `.none` enumeration case.
     case none
     /// The presence of a value, stored as `Wrapped`.
     case some(Wrapped)
     /// Creates an instance that stores the given value.
     public init(_ some: Wrapped)
 }
 */
func test07() {
    print("-------------test07-------------------")
    var age: Int? = 10
    var age0: Optional<Int> = 10
    var age1: Optional<Int> = Optional<Int>.some(10)
    var age2: Optional = .some(10)
    var age3 = Optional.some(10)
    var age4 = Optional(10.0)
    print(age, age0, age1, age2, age3, age4)
    age = nil
    age = Optional.none
    age = .none
    print(age)
    
    var tempAge: Int? = .none
    tempAge = 10
    tempAge = .some(20)
    print("tempAge = \(tempAge!)")
    
    switch tempAge {
    case let v?:
        print("some", v)
    case nil:
        print("none")
    }
    switch tempAge {
    case let .some(v):
        print("some", v)
    case .none:
        print("none")
    }
}
test07()

/// 可选项的可选项
func test08() {
    print("-------------test08-------------------")
    var age0: Int? = 10
    var age00: Int?? = age0
    print(age0, age00)
    age0 = nil
    print(age0, age00)
    
    var age1 = Optional.some(Optional.some(10))
    var age11: Optional<Optional> = .some(10)
    age1 = nil
    print("age1 = ", age1, age11)
    
    var age2: Int?? = 10
    var age22: Optional<Optional> = 10
    print("age2 = ", age2, age22)
}
test08()




