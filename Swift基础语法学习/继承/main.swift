//
//  main.swift
//  继承
//
//  Created by liutong on 2021/7/17.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 继承（Inheritance）
/*
    值类型（枚举、结构体）不支持继承，只有类支持继承
    swift并没有OC、Java那样的规定：任何类最终都要继承某个基类
    子类可以重写父类的 下标、方法、属性 ，重写必须加上override关键字
 */
func test01() {
    print("-------------test01-------------------")
    class Animal {
        var age = 0
    }
    class Dog: Animal {
        var weight = 0
    }
    class ErHa: Dog {
        var iq = 0
    }
    let a = Animal()
    a.age = 10
    print("Animal Size:", Mems.size(ofRef: a))
    let d = Animal()
    d.age = 10
    print("Dog Size:", Mems.size(ofRef: d))
    let e = ErHa()
    e.age = 10
    print("ErHa Size:", Mems.size(ofRef: e))// 48 = 固定类信息16+8*3+8（内存对齐，malloc的地址都是16的倍数）
}
test01()

/// 重写实例方法、下标
func test02() {
    print("-------------test02-------------------")
    class Animal {
        func speak() -> Void {
            print("Animal speak")
        }
        subscript(index: Int) -> Int {
            return index
        }
    }
    class Cat: Animal {
        override func speak() {
            super.speak()
            print("Cat speak")
        }
        override subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    
    let a = Animal()
    a.speak()
    print(a[6])
    let c = Cat()
    c.speak()
    print(c[6])
}
test02()


/// 重写类型方法、下标
/// 被class修饰的类型方法、小标，允许被子类重写
/// 被static修饰的类型方法、小标，不允许被子类重写
func test03() {
    print("-------------test03-------------------")
    class Animal {
        class func speak() {
            print("Animal speak")
        }
        class subscript(index: Int) -> Int {
            return index
        }
    }
    class Dog: Animal {
        override class func speak() {
            super.speak()
            print("Dog speak")
        }
        override class subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    Animal.speak()
    Dog.speak()
}
test03()

/// 重写属性
/*
    子类可以将父类的属性（存储、计算）重写为 计算属性
    子类不可以将父类的属性重写为 存储属性
    只能重写var属性，不能重写let属性
    重写时，属性名、类型要一致
    子类重写后的属性权限 不能小于 父类属性的权限
        - 父类只读 -> 子类只读、或者可读写
        - 父类可读写 -> 子类必须可读写
 */

/// 重写实例属性
func test04() {
    print("-------------test04-------------------")
    class Circle {
        var radius = 0
        var diameter: Int{
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    
    class SubCircle: Circle {
        override var radius: Int {
            set {
                print("SubCircle setRadius")
                super.radius = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getRadius")
                return super.radius
            }
        }
        override var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.radius = newValue > 0 ? newValue / 2 : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.radius * 2
            }
        }
    }
    
    let circle = SubCircle()
    circle.diameter = 10
    print(circle.diameter, circle.radius)
}
test04()


/// 重写类型属性
/*
    被class修饰的 计算类型属性，可以被子类重写。（存储类型属性不能被class修饰）
    被static修饰的类型属性（存储、计算），不可以被子类重写
 */
func test05() {
    print("-------------test05-------------------")
    class Circle {
        static var radius: Int = 0
        class var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    class SubCircle : Circle {
        override class var diameter: Int {
            set {
                print("SubCircle setDiameter")
                radius = newValue / 2
            }
            get {
                print("SubCircle getDiameter")
                return radius * 2
            }

        }
    }
    SubCircle.radius = 6
    print(SubCircle.diameter)
}
test05()

/// 属性观察器1：可以在子类中为父类属性（除了只读计算属性，let属性）增加属性观察器
func test06() {
    print("-------------test06-------------------")
    class Circle {
        var radius: Int = 1
    }
    class SubCircle : Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSet", newValue)
            }
            didSet {
                print("SubCirlce didSet", oldValue, radius)
            }
        }
    }
    let circle = SubCircle()
    circle.radius = 10
}
test06()

/// 属性观察器2
func test07() {
    print("-------------test07-------------------")
    class Circle {
        var radius: Int = 1 {
            willSet {
                print("Circle willSet", newValue)
            }
            didSet {
                print("Cirlce didSet", oldValue, radius)
            }
        }
    }
    class SubCircle : Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSet", newValue)
            }
            didSet {
                print("SubCirlce didSet", oldValue, radius)
            }
        }
    }
    let circle = SubCircle()
    circle.radius = 10
}
test07()

/// 属性观察器3：（注意获取oldValue需要先调用父类的get方法）
func test08() {
    print("-------------test08-------------------")
    class Circle {
        var radius: Int {
            set {
                print("Circle setRaidus", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle : Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSet", newValue)
            }
            didSet {
                print("SubCirlce didSet", oldValue, radius)
            }
        }
    }
    let circle = SubCircle()
    circle.radius = 10
}
test08()

/// 属性观察器4
func test09() {
    print("-------------test09-------------------")
    class Circle {
        class var radius: Int {
            set {
                print("Circle setRaidus", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle : Circle {
        override class var radius: Int {
            willSet {
                print("SubCircle willSet", newValue)
            }
            didSet {
                print("SubCirlce didSet", oldValue, radius)
            }
        }
    }
    SubCircle.radius = 10
}
test09()


/*
    final
    1、被final修饰的方法、下标、属性，禁止被重写
    2、被final修饰的类、禁止被继承
 
    多态（Polymorphism）
    有了继承，就要说到多态的使用
    - OC的多态机制是通过runtime机制来实现的，即运行时才知道要调用的方法
    - c++是通过虚函数表实现，编译时就确定了
    swift的多态与c++类似，eg：Dog继承Animal，Dog类的信息中，就会有eat方法的函数地址，因此Dog对象可以调用该方法。而OC是通过类对象一直往上找到函数调用地址
 */

func test10() {
    print("-------------test10-------------------")
    class Animal {
        func eat() -> Void {
            print("Animal eat")
        }
    }
    class Dog : Animal {
        func bark() -> Void {
            print("Dog brak")
        }
    }
    var a = Animal()
    a = Dog()
}
test10()
