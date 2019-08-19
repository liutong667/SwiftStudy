//
//  main.swift
//  1.常量变量
//
//  Created by liutong on 2019/8/19.
//  Copyright © 2019 刘通. All rights reserved.
//

import Foundation

/*
 输出:
 C: printf("Hello, World!");
 OC: NSLog(@"Hello, World!");
 */
print("Hello, World!")

/*
  “使用let来声明常量，使用var来声明变量”
 
 变量:
 OC:
 >先定义再初始化
 int num;
 num = 10;
 
 >定义的同时初始化
 int num2 = 20;
  */

/*
 Swift:
 >先定义再初始化
 var num
 报错: 没有指定数据类型(type annotation missing in pattern), 在Swift中如果想要先定义一个变量, 以后使用时再初始化必须在定义时告诉编译器变量的类型(类型标注)
 */
var num : Int
num = 10
print(num)

/*
 >定义的同时初始化
 在Swift中如果定义的同时初始化一个变量,可以不用写数据类型, 编译期会根据初始化的值自动推断出变量的类型(其它语言是没有类型推断的)
 以后在开发中如果在定义的同时初始化就没有必要指定数据类型, 除非需要明确数据类型的长度或者定义时不初始化才需要指定数据类型
 */
var num2 = 12
var num3 : Int8 = 13

print(num2,num3)

/*
 “你可以用任何你喜欢的字符作为常量和变量名，包括 Unicode 字符：”
 “常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，但是可以在常量与变量名的其他地方包含数字。”
 错误:
 var 3x = 10
 var x+-3 = 10
 */
var 🐥 = 100
var 嘿嘿 = 200
print(🐥,嘿嘿)

/*
 常量:
 OC: const int num = 10;
 Swift: let num = 10
 
 Swift和OC常量都可以在定义时初始化、或者之后初始化一次
 初始化之后不可再修改, 否则会报错
 常量的用途: 某些值以后不需要改变, 例如身份证
 
 错误用法：
 let num7
 num7 = 10
 */
let num4 = 1

let num5 : String = "kkkk"

let num6 : Int8
num6 = 16

print(num4,num5,num6)

