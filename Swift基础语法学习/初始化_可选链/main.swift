//
//  main.swift
//  初始化_可选链
//
//  Created by liutong on 2021/7/18.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 初始化器
/*
    类、结构体、枚举都可以定义初始化器
    类有2中初始化器：指定初始化器（designated initializer）、便捷初始化器（convenience initializer）
    - 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
    - 默认初始化器总是类的指定初始化器
    - 类偏向于少量指定初始化器，一个类通常只有一个指定初始化器
 
    初始化器的调用规则：
    - 指定初始化器必须从它的直系父类调用指定初始化器
    - 便捷初始化器必须从相同的类里边调用另一个初始化器
    - 便捷初始化器最终必须调用一个指定初始化器
    （初始化器的互相调用可以参考官方给调用顺序图示）
 
    //指定初始化器
     init(parameters) {
         statement
     }
    // 便捷初始化器
     convenience init(parameters) {
        statement
     }
 
    两段式初始化
    安全检查
    重写
    自动继承
 */
func test01() {
    print("-------------test01-------------------")
    
}
test01()

/// required关键字
/*
    用required修饰指定初始化器，表明其所有子类都必须实现该初始化器（通过继承或者重写实现）
    如果子类重写了required初始化器，也必须加上required，不用加override
 */
func test02() {
    print("-------------test02-------------------")
    class Person {
        required init(){}
        init(age: Int){}
    }
    class Student : Person {
        required init() {
            super.init()
        }
    }
}
test02()


/// 属性观察器：父类的属性在它自己的初始化器中赋值不会触发属性观察器，但在子类的初始化器中赋值会触发属性观察器
func test03() {
    print("-------------test03-------------------")
    class Person {
        var age : Int {
            willSet {
                print("Person WillSet", newValue)
            }
            didSet {
                print("Person didSet", oldValue, age)
            }
        }
        init() {
            age = 0
        }
    }
    class Student : Person {
        override init() {
            super.init()
            age = 10
        }
    }
    
    var p = Person()
    var s = Student()
}
test03()

/// 可失败初始化器
/*
    类、结构体、枚举都可以使用init？定义可失败初始化器
    不允许同时定义参数标签、参数个数、参数类型相同的可失败初始化器和非可失败初始化器
    可以用init！定义隐式解包的可失败初始化器
    可失败初始化器可以调用非可失败初始化器，非可失败初始化器调用失败初始化器需要进行解包
    如果初始化器调用一个可失败初始化器导致初始化失败，那么整个初始化过程都失败，并且失败之后的代码都停止执行
    可以用一个非可失败初始化器重写一个可失败初始化器，但反过来不行
 */
func test04() {
    print("-------------test04-------------------")
    class Person {
        var name: String
        init?(name: String) {
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
        init!(name: String, age: Int) {
//            if name.isEmpty {
//                return nil
//            }
            self.name = name
        }
    }
    let p = Person.init(name: "", age: 10)
    print(p)
    print(p?.name)
    
    //之前使用过的可失败初始化器
    let num = Int("1231")
    print(num!)
    enum Anwser: Int {
        case right, wrong
    }
    let an = Anwser(rawValue: 3)
    print(an?.rawValue)
}
test04()


/// 反初始化器（deinit）
/*
    deinit叫做反初始化器，类似以c++的析构函数、OC的delloc方法
    - 当类的实例对象被释放内存是，就会调用实例对象的deinit方法
    - deinit不接受任何参数、不能自行调用
    - 父类的deinit能被子类继承
    - 子类的deinit实现执行完毕后会调用父类的deinit
 */
func test05() {
    print("-------------test05-------------------")
    class Person {
        deinit {
            print("Person deinit")
        }
    }
    class Student : Person {
        deinit {
            print("Student deinit")
        }
    }
    _ = Student()
    
}
test05()

/// 可选链（Optional Chaining）
/*
    如果可选项为nil，调用方法、下标、属性失败，结果为nil
    如果可选项不为nil，调用方法、下标、属性成功，结果会被包装成可选项
    如果结果本来就是可选项，不会进行再次包装
 
    多个？可以链接在一起，如果链中任何一个节点是nil，那么整个链就会调用失败
 */
func test08() {
    print("-------------test08-------------------")
    class Car {
        var price = 0
    }
    class Dog {
        var weight = 0
    }
    class Person {
        var name: String = ""
        var dog: Dog = Dog()
        var car: Car? = Car()
        func age() -> Int {18}
        func eat() {print("Person eat")}
        subscript(index: Int) -> Int {index}
    }
    
    var person: Person? = Person()
    person = nil
    let dog = person?.dog
    let weight = dog?.weight
    let weight2 = person?.dog.weight
    let price = person?.car?.price
    print(dog as Any, weight, weight2, price)
    
    func getName() -> String {
        print("getName")
        return "jack"
    }
    // 如果person是nil，不会调用getName()
    person?.name = getName()
    
    // 可以判断方法是否调用成功
    if let _ = person?.eat() {
        print("eat调用成功")
    } else {
        print("eat调用失败")
    }
}
test08()


///
func test06() {
    print("-------------test06-------------------")
    var scores = ["Jack":[10,20,30],
                  "Rose":[11,21,31]]
    scores["Jack"]?[0] = 80
    scores["Rose"]![0] = 80
    scores["Kate"]?[0] = 80
    print(scores)
    
    var num1: Int? = 5
    num1? = 10
    var num2: Int? = nil
    num2? = 10
    print(num1,num2)
    
    let dict: [String: (Int, Int) -> Int] = ["sum":(+),"difference":(-)]
    let result = dict["sum"]?(10,20)
    let result2 = dict["di"]?(10,20)
    print(result, result2)
}
test06()
