//
//  main.swift
//  结构体和类
//
//  Created by liutong on 2021/7/11.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 结构体
func test01() {
    print("-------------test01-------------------")
    struct Date {
        var year: Int
        var month: Int
        var day: Int
    }
    var date = Date(year: 2021, month: 7, day: 11)
    print(date)
}
test01()

/// 初始化器
func test02() {
    print("-------------test02-------------------")
    struct Point {
        var x: Int?
        var y: Int?
    }
    let p1 = Point(x: 10, y: 10)
    let p2 = Point(x:10)
    let p3 = Point(y:10)
    let p4 = Point()
    print(p1, p2, p3, p4)
}
test02()

/// 自定义初始化器
func test03() {
    print("-------------test03-------------------")
//    struct Point {
//        var x: Int
//        var y: Int = 0
//        init(x: Int, y: Int) {
//            self.x = x
//            self.y = y
//        }
//    }
//    let p1 = Point(x: 10, y: 10)
//    let p2 = Point(x:10)
//    let p3 = Point(y:10)
//    let p4 = Point()
}
test03()

/// 结构体内存
func test04() {
    print("-------------test04-------------------")
    struct Point {
        var x: Int = 0
        var y: Int
        var orginal: Bool
        var des: String
    }
    print(MemoryLayout<Point>.size) // 17
    print(MemoryLayout<Point>.stride) // 24
    print(MemoryLayout<Point>.alignment) //8
}
test04()

/// 类
func test05() {
    print("-------------test05-------------------")
    class Point {
        var x: Int = 0
        var y: Int = 0
    }
    let p = Point()
}
test05()

///
func test06() {
    print("-------------test06-------------------")
    struct Point {
        var x: Int
        var y: Int
    }
    class Size {
        var w: Int
        var h: Int
        init(w:Int, h:Int) {
            self.w = w
            self.h = h
        }
    }
//    let p = Point(x: 10, y: 10)
//    p.x = 20
//    p.y = 20
//    let s = Size(w: 10, h: 10)
//    s.w = 20
//    s.h = 20
//
//    let str = "jack"
//    str.append("rose")
//
//    let arr = [1,2,3]
//    arr[0] = 10
}
test06()

///
func test07() {
    print("-------------test07-------------------")
    struct Point {
        var x: Int
        var y: Int
        func show() {
            print("x = \(self.x), y = \(self.y)")
        }
    }
    class Size {
        var w: Int = 0
        var h: Int = 0
        func show() {
            print("w = \(self.w), h = \(self.h)")
        }
    }
    enum Direction:String {
        case east = "东", south = "南", west = "西", north = "北"
        func show() {
            print("dir is \(self.rawValue)")
        }
    }
    Point.init(x: 10, y: 10).show()
    Size.init().show()
    Direction.east.show()
}
test07()

/// 枚举内存
func test08() {
    print("-------------test08-------------------")
    enum TestEnum {
        case test1(Int, Int, Int, Bool)
        case test2(String)
        case test3(Bool)
        case test4
    }
    print(MemoryLayout<TestEnum>.size) //25
    print(MemoryLayout<TestEnum>.stride) //32
    print(MemoryLayout<TestEnum>.alignment) //8
    
}
test08()

///结构体内存
func test09() {
    print("-------------test09-------------------")
    struct Point {
        var x: Int
        var y: Int
        var big: Bool
        var small: Bool
    }
    var p = Point(x: 10, y: 10, big: true, small: false)
    print(MemoryLayout<Point>.size)
    print(MemoryLayout<Point>.stride)
    print(MemoryLayout<Point>.alignment)
}
test09()

/// 类
func test10() {
    print("-------------test10-------------------")
    class Size {
        var w: Int = 0
        var h: Int = 0
        var big: Bool
        var small: Bool
        init(big: Bool, small: Bool) {
            self.big = big
            self.small = small
        }
    }
    let s = Size(big: true, small: false)
    print(class_getInstanceSize(type(of: s))) // 40
    print(class_getInstanceSize(Size.self)) //40
    
}
test10()
