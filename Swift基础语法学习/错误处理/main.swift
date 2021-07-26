//
//  main.swift
//  错误处理
//
//  Created by liutong on 2021/7/24.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 自定义错误

// swift中可以通过Error协议自定义运行时的错误信息
enum SomeError : Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

// 函数内部通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明
func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1/num2
}

func test01() {
    print("-------------test01-------------------")
    // 需要使用try调用可能会抛出Error的函数
    let res = try? divide(10, 5)
    print(res as Any)
}
test01()

/// do-catch：可以使用do-catch捕捉Error；抛出Error后，try下一句直到作用域结束的代码都将停止运行
func test02() {
    print("-------------test02-------------------")
    func test() {
        print(1)
        do {
            print(2)
            print(try divide(10, 1))
            print(3)
        } catch let SomeError.illegalArg(msg) {
            print("参数异常，", msg)
        } catch let SomeError.outOfBounds(size, index) {
            print("数组越界：",size, index)
        } catch {
            print("其他错误")
        }
        print(4)
    }
    test()
    
    do {
        let res = try divide(10, 5)
        print(res as Any)
    } catch let error {
        switch error {
        case let SomeError.illegalArg(msg):
            print(msg)
        default:
            print("other")
        }
    }
    
}
test02()


/// 处理Error
/*
    1、通过do-catch捕捉Error
    2、不捕捉Error，在当前函数增加throws声明，Error将自动抛给上层函数。如果最顶层函数（main函数）依然没有捕捉Error，那么程序将终止
 */
func test03() {
    print("-------------test03-------------------")
    func test() throws {
        print(1)
        print(try divide(100, 10))
        print(2)
    }
//    try test()
    
//    do {
//        try divide(100, 10)
//    } catch is SomeError {
//        print("SomeError")
//    }
    
//    func test2() throws {
//        print(1)
//        do {
//            print(2)
//            print(try divide(100, 10))
//            print(3)
//        } catch let error as SomeError {
//            print(error)
//        }
//        print(4)
//    }
//    try test()
}
test03()

/// try?、try!  ：可以使用此调用可能会抛出Error的函数，这样就不用去出来Error
func test04() {
    print("-------------test04-------------------")
    func test() {
        print(1)
        print(try? divide(100, 10))
        print(try? divide(100, 0))
        print(try! divide(100, 10))
//        print(try! divide(100, 0))
        print(2)
    }
    test()
}
test04()

/// rethrows：表明函数本身不会抛出错误，但调用闭包（函数）参数参数抛出错误，那么它会将错误向上抛
func test05() {
    print("-------------test05-------------------")
    func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
        print(try? divide(num1, num2))
    }
    try? exec(divide(_:_:), 100, 10)
}
test05()

/// defer
/*
    defer语句用来定义以任何方式（return、throw等）离开代码块之前必须要执行的代码
    defer语句定义后将延迟到当前作用域结束之前执行
    defer语句的执行顺序与定义顺序相反
 */
func test06() {
    print("-------------test06-------------------")
    func open(_ fileName: String) -> Int{
        print("open file")
        return 0
    }
    func close(_ file: Int) {
        print("close file")
    }
    func processFile(_ fileName: String) throws {
        print(1)
        let file = open(fileName)
        defer {
            print(4)
            close(file)
        }
        print(2)
        print(try divide(100, 0))
        print(3)
    }
    try? processFile("test.txt")
    
    func test() {
        defer {
            print(111)
        }
        defer {
            print(222)
        }
        print(333)
    }
    test()
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




