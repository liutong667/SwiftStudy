//
//  main.swift
//  枚举
//
//  Created by liutong on 2021/7/9.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 00、枚举基本用法
func test00() {
    print("-------------test00-------------------")
    enum Direction1 {
        case east
        case south
        case west
        case north
    }
    var dir = Direction1.east
    dir = .north
    dir = Direction1.south
    print(dir)
    enum Direction2 {
        case east, south, west, north
    }
    let dir2 = Direction2.east
    switch dir2 {
    case .east:
        print("east")
    case Direction2.south:
        print("south")
    case Direction2.west:
        print("east")
    case Direction2.north:
        print("south")
    }
}
test00()

/// 01、关联值（Associated Values）
func test01() {
    print("-------------test01-------------------")
    enum Score {
        case points(Int)
        case grade(Character)
    }
    var stuScore = Score.points(90)
    stuScore = Score.grade("A")
    switch stuScore {
    case .points(let i):
        print("score = \(i)")
    case let .grade(i):
        print("score = \(i)")
    }
    enum Date {
        case digit(year:Int, month:Int, day:Int)
        case string(String)
    }
    var currentDate = Date.digit(year: 2021, month: 7, day: 10)
    currentDate = Date.string("2021-7-10")
    switch currentDate {
    case let .digit(year, month, day):
        print("currentDate = \(year)-\(month)-\(day)")
    case let .string(dateStr):
        print("currentDate = \(dateStr)")
    }
}
test01()

/// 02、原始值（Raw Values） （原始值不占用枚举的内存值）
func test02() {
    print("-------------test02-------------------")
    enum Grade:String {
        case gradeA = "A"
        case gradeB = "B"
    }
    var tempGrade = Grade.gradeA
    tempGrade = Grade.gradeB
    print("tempGrade = \(tempGrade)")
    print("tempGrade raw value = \(tempGrade.rawValue)")
    print(Grade.gradeB.rawValue)
}
test02()

/// 03、隐式原始值（Implicitly Assigned Raw Values）
//  如果枚举的原始值类型是Int，String，swift会自动分配原始值
func test03() {
    print("-------------test03-------------------")
    enum Direction: String {
        case east = "east"
        case south = "south"
        case west = "west"
        case north = "north"
    }
    enum Direction2: String {
        case east, south, west, north
    }
    print(Direction.east.rawValue)
    print(Direction2.east.rawValue)
    
    enum Season: Int {
        case spring, summer, autumn, winter
    }
    print(Season.spring, Season.summer)
    print(Season.spring.rawValue, Season.summer.rawValue, Season.autumn.rawValue, Season.winter.rawValue)
    
    enum Season2: Int {
        case spring, summer, autumn = 6, winter
    }
    print(Season2.spring.rawValue, Season2.summer.rawValue, Season2.autumn.rawValue, Season2.winter.rawValue)
}
test03()

/// 04、MemoryLayout 可以查看数据类型占用内存的大小
func test04() {
    print("-------------test04-------------------")
    enum Password {
        case number(Int, Int, Int, Int)
        case gesture(ges:String)
    }
    print(MemoryLayout<Password>.stride) // 40 实际分配的内存大小
    print(MemoryLayout<Password>.size) // 33 实际用到的内存大小
    print(MemoryLayout<Password>.alignment) // 8 内存对齐值
    
    var pwd = Password.number(1, 2, 3, 4)
    pwd = Password.gesture(ges: "789809")
    print(MemoryLayout.stride(ofValue: pwd))
    print(MemoryLayout.size(ofValue: pwd))
    print(MemoryLayout.alignment(ofValue: pwd))
}
test04()

/// 05、
func test05() {
    print("-------------test05-------------------")
    print("-------------testEnum-------------------")
    enum TestEnum {
        case test1, test2, test3
    }
    let tempT = TestEnum.test1
    print(MemoryLayout<TestEnum>.stride)
    print(MemoryLayout<TestEnum>.size)
    print(MemoryLayout<TestEnum>.alignment)
    print(MemoryLayout.stride(ofValue: tempT))
    print(MemoryLayout.size(ofValue: tempT))
    print(MemoryLayout.alignment(ofValue: tempT))
    
    print("-------------testEnum2-------------------")
    enum TestEnum2: Int {
        case test1, test2 = 3, test3
    }
    let tempT2 = TestEnum2.test1
    print(MemoryLayout<TestEnum2>.stride)
    print(MemoryLayout<TestEnum2>.size)
    print(MemoryLayout<TestEnum2>.alignment)
    print(MemoryLayout.stride(ofValue: tempT2))
    
    print("-------------testEnum3-------------------")
    enum TestEnum3 {
        case test1(Int)
        case test2(Int, Int, Int)
        case test3(Bool)
        case test4(String)
    }
//    let tempT3 = TestEnum3.test1(10)
    print(MemoryLayout<TestEnum3>.stride)
    print(MemoryLayout<TestEnum3>.size)
    print(MemoryLayout<TestEnum3>.alignment)
//    print(MemoryLayout.stride(ofValue: tempT3))
}
test05()

/// 06、
func test06() {
    print("-------------test06-------------------")

}
test06()

