//
//  main.swift
//  协议
//
//  Created by liutong on 2021/7/24.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation


/// 协议（Protocol）
/*
    协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守（多个协议之间用逗号隔开）
    协议中定义方法时不能有默认参数值
    默认情况下，协议中定义的内容必须全部都实现（也有办法办到只实现部分内容）
    
 */

protocol Drawable1 {
    func draw()
    func draw(pencil: String)
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

func test01() {
    print("-------------test01-------------------")
}
test01()

/// 协议中的属性
/*
    协议中定义属性时必须用var关键字
    实现协议时的属性权限要不小于协议中定义的属性权限，即：
    1、协议中定义get、set，用var存储属性或者get、set计算属性实现
    2、协议中定义get，用任何属性都可以实现
 */

protocol Drawable2 {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

func test02() {
    print("-------------test02-------------------")
    class Person : Drawable2 {
        var x: Int = 0
        let y: Int = 0
        func draw() {
            print("Person draw")
        }
        subscript(index: Int) -> Int {
            get { index }
            set {}
        }
    }
    
    class Person2 : Drawable2 {
        var x: Int {
            get { 0 }
            set {}
        }
        var y: Int { 0 }
        func draw() {
            print("Person draw")
        }
        subscript(index: Int) -> Int {
            get { index }
            set {}
        }
    }
}
test02()


/// static、class：为了保证通用，协议中必须用static定义类型方法、属性、类型下标
protocol Drawable3 {
    static var x: Int { get set }
    static var y: Int { get }
    static func draw()
}

func test03() {
    print("-------------test03-------------------")
    class Person : Drawable3 {
        static var x: Int = 0
        static var y: Int = 0
        static func draw() {
        }
    }
    class Person2 : Drawable3 {
        static var x: Int = 0
        static var y: Int = 0
        class func draw() {
        }
    }
}
test03()

/// mutating
/*
    只有将协议中的实例方法标记为mutating，才允许结构体、枚举的具体实现修改自身内存
    类在实现方法时不用加mutating，枚举、结构体才需要加mutating
 */
protocol Drawable4 {
    mutating func draw()
}
func test04() {
    print("-------------test04-------------------")
    class Size : Drawable4 {
        var width: Int = 0
        func draw() {
            width = 10
        }
    }
    struct Point : Drawable4 {
        var x: Int = 0
        var y: Int = 0
        mutating func draw() {
            x = 10
            y = 20
        }
    }
}
test04()

/// init
/*
    协议中还可以定义初始化器init，非final类实现时必须加上required
    如果协议实现的初始化器，刚好是重写了父类的指定初始化器，那么需要同时加上override、required
 */
protocol Drawable5 {
    init(x: Int, y: Int)
}
protocol Liveable {
    init(age: Int)
}
func test05() {
    print("-------------test05-------------------")
    ///
    class Point: Drawable5 {
        required init(x: Int, y: Int) {
        }
    }
    final class Size: Drawable5 {
        init(x: Int, y: Int) {
        }
    }
    ///
    class Person {
        init(age: Int){}
    }
    class Student : Person, Liveable {
        required override init(age: Int) {
            super.init(age: age)
        }
    }
}
test05()

/// init、init?、init!
/// 协议中定义的init？、init！，可以用init、init？、init！去实现
/// 协议中定义的init， 可以用init、init！去实现
protocol Liveable6 {
    init()
    init?(age: Int)
    init!(no: Int)
}
func test06() {
    print("-------------test06-------------------")
    class Person : Liveable6 {
        required init() {}
//        required init!() {}
        
        required init?(age: Int) {}
//        required init!(age: Int) {}
//        required init(age: Int) {}
        
        required init!(no: Int) {}
//        required init?(no: Int) {}
//        required init(no: Int) {}
    }
}
test06()


/// 协议的继承：一个协议可以继承其他协议
protocol Runable7 {
    func run()
}
protocol Liveable7 : Runable7 {
    func breath()
}
func test07() {
    print("-------------test07-------------------")
    class Person : Liveable7 {
        func run() {
        }
        func breath() {
            
        }
    }
}
test07()

/// 协议组合：可以包含1个类类型（最多一个）
protocol Liveable8 {}
protocol Runable8 {}
func test08() {
    print("-------------test08-------------------")
    class Person {}
    
    func fn0(obj: Person) {}
    func fn1(obj: Liveable8) {}
    func fn2(obj: Runable8) {}
    func fn3(obj: Liveable8 & Runable8) {}
    func fn4(obj: Person & Liveable8 & Runable8) {}
    typealias RealPerson = Person & Liveable8 & Runable8
    func fn5(obj: RealPerson) {}
}
test08()


/// 两种协议CaseIterable、CustomStringConvertible
func test09() {
    print("-------------test09-------------------")
    // 让枚举遵循CaseIterable协议，可以实现遍历枚举值
    enum Season : CaseIterable {
        case spring, summer, autumn, winter
    }
    let seasonArray = Season.allCases
    print(seasonArray.count)
    for s in seasonArray {
        print(s)
    }
    
    //遵守CustomStringConvertible/CustomDebugStringConvertible协议，都可以自定义实例的打印字符串
    // print调用的是CustomStringConvertible协议的description
    // debugPoint、po调用的是CustomDebugStringConvertible协议的debugDescription
    class Person : CustomStringConvertible, CustomDebugStringConvertible {
        var age = 0
        var description: String {
            "person_\(age)"
        }
        var debugDescription: String {
            "debug_person_\(age)"
        }
    }
    let p = Person()
    print(p)
}
test09()

/// Any、AnyObject
/*
    swift提供了2种特殊的类型：Any、AnyObject
    Any：可以代表任意类型（类、枚举、结构体，也包括函数类型）
    AnyObject：可以代表任意_类_类型（在协议后面加上AnyObject：表示只有类可以实现该协议，或者在协议后面加上class，也可以）
 */
func test10() {
    print("-------------test10-------------------")
    var stu: Any = 10
    stu = "jack"
    
    var anyArray = [Any]()
    var anyArray2 = Array<Any>()
    anyArray.append(1)
    anyArray.append(3.14)
    anyArray.append("jack")
    anyArray.append({10})
    print(anyArray)
}
test10()

/// is、as？、as！、as：is用来判断是否为某种类型，as用来强制类型转换
protocol Runable11 {
    func run()
}
func test11() {
    print("-------------test11-------------------")
    class Person {}
    class Student : Person, Runable11 {
        func run() {
            print("Student run")
        }
        func study() {
            print("Student study")
        }
    }
    var stu: Any = 10
    print(stu is Int) // true
    stu = "jack"
    print(stu is String) //true
    stu = Student()
    print(stu is Student) //true
    print(stu is Person) //true
    print(stu is Runable11) //true
    
    stu = 10
    (stu as? Student)?.study()
    stu = Student()
    (stu as? Student)?.study()
    (stu as! Student).study()
    (stu as! Runable11).run()
    
    var data = [Any]()
    data.append(Int("123") as Any)
    print(data)
    let d = 10 as Double
    print(d)
}
test11()

/// X.self、X.Type、AnyClass
// X.self是一个元类型（metadata）的指针，metadata存放着类型相关信息，与实例对象内存前8个字节指向信息一样
// X.self属于X.Type类型
func test12() {
    print("-------------test12-------------------")
    class Person {}
    class Student : Person {}
    var personType : Person.Type = Person.self
    var studentType : Student.Type = Student.self
    personType = Student.self
    
    ///
    var anyType: AnyObject.Type = Person.self
    anyType = Student.self
//    public typealias AnyClass = AnyObject.Type
    var anyType2: AnyClass = Person.self
    anyType2 = Student.self
}
test12()

///
func test13() {
    print("-------------test13-------------------")

}
test13()

///
func test14() {
    print("-------------test14-------------------")

}
test14()



