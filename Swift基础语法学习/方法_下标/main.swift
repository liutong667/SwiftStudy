//
//  main.swift
//  方法_下标
//
//  Created by liutong on 2021/7/17.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 方法（Method）
/*
    枚举、结构体、类都可以定义实例方法、类型方法
    实例方法（Instance Method）：通过实例对象调用
    类型方法（Type Method）：通过类型调用，用static 或者 class 关键字定义
    self：在实例方法中代表实例对象，在类型方法中代表类型
 */
func test01() {
    print("-------------test01-------------------")
    class Car {
        static var count = 0
        init() {
            Car.self.count += 1
        }
        static func getCarCount() -> Int { count }
    }
    _ = Car()
    _ = Car()
    print(Car.getCarCount())
    /// 在类型方法static func getCarCount()中，count等价于self.count、Car.self.count、Car.count
}
test01()

/// mutating
/// 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
/// 在func关键字前加mutating可以允许这种修改行为
func test02() {
    print("-------------test02-------------------")
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(deltaX: Double, deltaY: Double) -> Void {
            x += deltaX
            y += deltaY
            self = Point(x: 10, y: 10)
        }
    }
    var p = Point()
    print(p)
    p.moveBy(deltaX: 30, deltaY: 30)
    print(p)
}
test02()

/// @discardableResult ，在func前面加个@discardableResult，可以消除函数调用后返回值未被使用的警告⚠️
func test03() {
    print("-------------test03-------------------")
    struct Point {
        var x = 0.0, y = 0.0
        @discardableResult mutating
        func moveX(deltaX: Double) -> Double {
            x += deltaX
            return x
        }
    }
    var p = Point()
    print(p)
    p.moveX(deltaX: 10)
    print(p)
}
test03()

/// 下标（subscript）
/// 使用subscript可以给任意类型（枚举、结构体、类）增加下标功能，subscript的语法类似于实例方法、计算属性，本质就是方法（函数）
/// - subscript中定义的返回值类型决定了 ：1、get方法的返回值类型；2、set方法中newValue的类型
/// - subscript可以接受多个参数，并且类型任意
func test04() {
    print("-------------test04-------------------")
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            set {
                if index == 0 {
                    x = newValue
                } else if index == 1 {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    let p = Point()
    p[0] = 1
    p[1] = 1
    print(p.x, p.y)
    print(p[0], p[1])
}
test04()

/// 下标使用一
func test05() {
    print("-------------test05-------------------")
    // subscript可以没有set方法，但必须要有get方法
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    //如果只有get方法，可以省略get
    class Point2 {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
    print(Point()[0])
}
test05()

/// 下标使用二
func test06() {
    print("-------------test06-------------------")
    //可以设置参数标签
    class Point {
        var x = 0.0, y = 0.0
        subscript(index i: Int) -> Double {
            if i == 0 {
                return x
            } else if i == 1 {
                return y
            }
            return 0
        }
    }
    let p = Point()
    p.y = 10
    print(p[index: 1])
    
    //下标可以是类型方法
    class Sum {
        static subscript(v1: Int, v2: Int) -> Int {
            return v1 + v2
        }
    }
    print(Sum[10, 20])
}
test06()


/// 下标使用三：接受多个参数的下标
func test07() {
    print("-------------test07-------------------")
    class Gird {
        var data = [[1,2,3],
                    [4,5,6],
                    [7,8,9]]
        subscript(row: Int, column: Int) -> Int {
            set {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return
                }
                data[row][column] = newValue
            }
            get {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return 0
                }
                return data[row][column]
            }
        }
    }
    let gird = Gird()
    gird[1,1] = 100
    print(gird[1,1])
    print(gird.data)
}
test07()

/// 下标使用四：结构体、类作为返回值对比
func test08() {
    print("-------------test08-------------------")
    class PointClass {var x = 0.0, y = 0.0}
    class PointClassManager {
        var point = PointClass()
        subscript(index:Int) -> PointClass {
            return point
        }
    }
    let pm = PointClassManager()
    pm[0].x = 11
    pm[1].y = 22
    print(pm.point.x, pm.point.y)
    
    struct PointStruct {var x = 0.0, y = 0.0}
    class PointStructManager {
        var point = PointStruct()
        subscript(index:Int) -> PointStruct {
            return point
        }
    }
    var pm2 = PointStructManager()
//    pm2[0].x = 11
//    pm2[1].y = 22
    print(pm2.point.x, pm2.point.y)
}
test08()
