//
//  main.swift
//  可选项
//
//  Created by liutong on 2021/7/10.
//  Copyright © 2021 刘通. All rights reserved.
//

import Foundation

/// 00、可选项（Optional）
func test00() {
    print("-------------test00-------------------")
    var name: String? = "jack"
    name = nil
    name = "mary"
    print(name!)
    
    let array = [1,2,3]
    func get(_ index: Int) -> Int? {
        if index < 0 || index > array.count {
            return nil
        }
        return array[index]
    }
    print(get(0))
    print(get(-1))
    print(array[2])
}
test00()

/// 01、判断可选项是否包含值
func test01() {
    print("-------------test01-------------------")
    let number = Int("123")
    if number != nil {
        print("change success res = \(number!)")
    } else {
        print("change error")
    }

}
test01()

/// 02、可选项绑定（Optional Binding）
func test02() {
    print("-------------test02-------------------")
    if let number = Int("2345") {
        print("change success res = \(number)")
    } else {
        print("change error")
    }
    
    enum Seaons: Int {
        case spring = 1, summer, autumn, winter
    }
    if let season = Seaons(rawValue: 1) {
        switch season {
        case .spring:
            print("the season is spring")
        default:
            print("this season is other")
        }
    } else {
        print("no such season")
    }
}
test02()

/// 03、等价的写法
func test03() {
    print("-------------test03-------------------")
    if let first = Int("1") {
        if let second = Int("2") {
            if first < second , second < 100 {
                print("111-----\(first)<\(second)<100")
            }
        }
    }
    
    if let first = Int("1"), let second = Int("2"), first < second, second < 100 {
        print("222-----\(first)<\(second)<100")
    }
}
test03()

/// 04、while 循环中使用可选项绑定
func test04() {
    print("-------------test04-------------------")
    let str = ["10", "20", "-30", "abc", "-10"]
    var i:Int = 0
    var sum = 0
    while let num = Int(str[i]), num > 0 {
        sum += num
        i += 1
    }
    print(sum)
}
test04()

/// 05、空合并运算符 ??（Nil-Coalescing Operatior）
func test05() {
    print("-------------test05-------------------")
    let a: Int? = nil
    let b: Int = 2
    var c: Int
    if let temp = a {
        c = temp
    } else {
        c = b
    }
//    let a: Int? = 1
//    let b: Int? = 2
//    let c = a ?? b // Optional(1)
//    print(c)
}
test05()

/// 07、guard语句
func test07() {
    print("-------------test07-------------------")
    func login(_ userInfo:[String: String]) {
        let userName: String
        if let temp = userInfo["username"] {
            userName = temp
        } else {
            print("请输入用户名")
            return
        }
        let passWord: String
        if let temp = userInfo["password"] {
            passWord = temp
        } else {
            print("请输入密码")
            return
        }
        print("用户名：\(userName), 密码\(passWord), 登录成功")
    }
    
    func login2(_ userInfo:[String: String]) {
        guard let userName = userInfo["username"] else {
            print("请输入用户名")
            return
        }
        guard let passWord = userInfo["password"] else {
            print("请输入密码")
            break
        }
        print("用户名：\(userName), 密码\(passWord), 登录成功")
    }
    
    login(["username":"jack","password":"123"])
    login2(["username":"","password":"123"])
}
test07()
