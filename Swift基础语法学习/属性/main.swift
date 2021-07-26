//
//  main.swift
//  属性
//
//  Created by liutong on 2021/7/13.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 属性
/*
    实例相关的属性分为2大类
    1、存储属性（Stored Property）
        类似于成员变量的概念
        存储在实例的内存中
        结构体、类可以定义存储属性，枚举不可以定义存储属性
    2、计算属性（Computed Property）
        本质就是方法（函数）
        不占用实例内存
        枚举、结构体、类都可以定义计算属性
 */
func test01() {
    print("-------------test01-------------------")
    struct Circle {
        var raius: Double //存储属性
        var diameter: Double { //计算属性
            get {
                return raius * 2
            }
            set {
                raius = newValue / 2
            }
        }
    }
    var circle = Circle(raius: 10)
    print(circle.raius)
    print(circle.diameter)
    circle.diameter = 50
    print(circle.raius)
    print(circle.diameter)
}
test01()


/*
    存储属性：
    swift规定在创建 类 或 结构体 的实例时，必须为所有的存储属性设置一个合适的初始值，因此可以
    1、可以在初始化器里边为存储属性设置一个初始值
    2、可以分配一个默认的属性值作为属性定义的一部分
    计算属性：
    1、set传入的新值默认叫做newValue，也可以自定义
    2、只读计算属性：只有get，没有set。（可省略get关键字）
    3、定义计算属性只能用var，不能用let（①let代表常量 即值是不变的；②计算属性的值是可能发生变化，即使是可读计算属性）
    
 */
func test02() {
    print("-------------test02-------------------")
    struct Circle {
        var radius : Double = 5
        var diameter: Double {
            set (newDiameter) {
                self.radius = newDiameter / 2
            }
            get {
                radius * 2
            }
        }
    }
    struct Circle2 {
        var radius : Double = 5
        var diameter: Double {
            get {
                radius * 2
            }
        }
    }
    struct Circle3 {
        var radius : Double = 5
        var diameter: Double { radius * 2 }
    }
}
test02()

/// 枚举rawValue原理
func test03() {
    print("-------------test03-------------------")
    enum TestEnum : Int {
        case test1 = 1, test2 = 2, test3
        var rawValue: Int {
            switch self {
            case .test1:
                return 10
            case .test2:
                return 20
            case .test3:
                return 30
            }
        }
    }
    print(TestEnum.test3.rawValue)
}
test03()

/// 延迟存储属性（Lazy Stored Propert）
/*
    使用lazy可以定义一个延迟存储属性，即在第一次用到属性的时候才会进行初始化
    - lazy属性必须是var，不能是let。 let必须保证在实例的初始化方法完成之前就拥有值
    - 如果多条线程同时第一次访问lazy属性，无法保证属性只被初始化1次
 */
func test04() {
    print("-------------test04-------------------")
    class Car {
        init() {
            print("car init")
        }
        func run() -> Void {
            print("car is running")
        }
    }
    class Person {
        lazy var car = Car()
        init() {
            print("person init")
        }
        func goOut() -> Void {
            car.run()
        }
    }
    let p = Person()
    p.goOut()
    
    /// 当结构体包含延迟存储属性是，只有var才能访问延迟存储属性。因为延迟属性初始化时 需要改变结构体的内存
    struct Point {
        var x = 0
        var y = 0
        lazy var z = 0
    }
//    let point = Point()
    var point = Point()
    print(point.z)
}
test04()

/// 属性观察器（Property Observer）
/*
    willSet会传递新值，默认叫newValue
    didSet会传递旧值，默认叫oldValue
    在初始化器中设置属性值不会触发willSet和didSet
    在属性定义是设置初始值也不会触发willSet和didSet
 */
func test05() {
    print("-------------test05-------------------")
    struct Circle {
        var radius: Double = 0.5
        {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
        init() {
            radius = 1.0
            print("Circle init")
        }
    }
    var circle = Circle()
    circle.radius = 2.0
    print(circle.radius)
    
    ///属性观察器、计算属性的功能，同样可以应用在全局变量、局部变量上
    print("-------------局部变量属性观察器-------------------")
    var num: Int = 1 {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, num)
        }
    }
    num = 2
    print("num = ", num)
    
}
test05()

/// 类型属性（Type Property）：只能通过类型去访问
/*
    - 存储类型属性（Stored Type Property）：整个程序运行过程中，就只有1份内存（类似于全局变量）
    - 计算类型属性（Computed Type Property）
    - 可以通过static定义类型属性，如果是类，也可以用class关键字
    类型属性注意点：
    - 不同于存储实例属性，必须给存储类型属性设定初始值（因为类型没有像实例那样的init初始化器来初始化存储属性）
    - 存储类型属性默认就是lazy，会在第一次使用的时候才初始化（多线程同时访问，可以保证只初始化一次，线程安全，因为底层实现是用dispatch once初始化的；存储类型属性可以是let）
    - 枚举类型也可以定义类型属性（存储类型属性、计算类型属性）
 */
func test06() {
    print("-------------test06-------------------")
    struct Car {
        static var count: Int = 0
        init() {
            Car.count += 1
        }
    }
    _ = Car()
    _ = Car()
    print("car count = ", Car.count)
    
}
test06()

/// inout关键字
/*
    inout本质总结
    - 1、如果实参有物理内存地址，且没有设置属性观察器 -> 直接将实参的内存地址传入函数（实参就行引用传递）
    - 2、如果实参是计算属性 或者 设置了属性观察器 -> 采取了Copy In Copy Out的做法
        2.1 调用改函数时，先复制实参的值，产生副本get
        2.2 将副本的内存地址传入函数（副本进行引用传递），在函数内部可以修改副本的值
        2.3 函数返回后，再将副本的值覆盖实参的值set
 */
func test07() {
    print("-------------test07-------------------")
    struct Shape {
        var sideLength: Int
        var sideNum: Int {
            willSet {
                print("willSetSideNum:", newValue)
            }
            didSet {
                print("didSetSideNum:", oldValue, sideNum)
            }
        }
        var shapeGirth: Int {
            set {
                sideLength = newValue / sideNum
                print("setShapeGirth:", newValue)
            }
            get {
                print("getShapeGirth")
                return sideLength * sideNum
            }
        }
        func show() {
            print("sildeLength:", sideLength, "slideNum:", sideNum, "shapeGirgth:", shapeGirth)
        }
    }
    func test(_ num: inout Int) {
        num = 20
    }
    var s = Shape(sideLength: 10, sideNum: 4)
    test(&s.sideLength)
    s.show()
    print("---------------")
    test(&s.sideNum)
    s.show()
    print("---------------")
    test(&s.shapeGirth)
    s.show()
    print("---------------")
}
test07()

/////
//func test06() {
//    print("-------------test06-------------------")
//
//}
//test06()
//
/////
//func test06() {
//    print("-------------test06-------------------")
//
//}
//test06()
