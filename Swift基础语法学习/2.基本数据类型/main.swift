//
//  main.swift
//  2.基本数据类型
//
//  Created by liutong on 2019/8/19.
//  Copyright © 2019 刘通. All rights reserved.
//

import Foundation

/*
 基本数据类型
 OC:
 整型  int intValue = 10;
 浮点型 double doubleValue = 10.10; float floatValue = 5.1;
 长 long
 短 short
 有符号 signed
 无符号 unsigned
 各种类型的数据的取值范围在不同位的编译器下取值范围不同
 
 Swift:注意关键字大写
 */

//整型
var intValue1 : Int = 10
//浮点型
var floatValue : Float = 10.1   // 表示32位浮点数
var doubleValue : Double = 10.2 // 表示64位浮点数

//如果按照长度划分,Swift中的长短比OC更加精确
var intValue3:Int8 = -128   //(-128 ~ 127)
var intValue4:Int16 = 7
var intValue5:Int32 = 8
var intValue6:Int64 = 9

//有符号无符号, 默认是有符号的(UInt8/UInt16/UInt32/UInt64)
var uintValue7:UInt8 = 255    //(0 ~ 255)
//注意：无符号的数比有符号的取值范围更大, 因为符号位也用来存值

//Swift是类型安全的语言, 如果取值错误会直接报错, 而OC不会
/*
 取值不对
 OC:unsigned int intValue = -10; 不会报错
 Swift:var intValue:UInt = -10 会报错
 溢出:
 OC:int intValue = INT_MAX + 1; 不会报错
 Swift:var intValue:UInt = UInt.max + 1 会报错
 */

/*
 数据类型的相互赋值(隐式类型转换)
 OC可以
 int intValue = 10;
 double doubleValue = intValue;
 
 Swift:不可以
 var intValue:Int = 10
 var doubleValue:Double = intValue
 在Swift中“值永远不会被隐式转换为其他类型”(OC中可以隐式类型转换), 以上语句会报错
 */

/*
 类型转换：
 Swift不允许隐式类型转换, 但可以使用显示类型转换(强制类型转换)
 OC:
 int intValue = 10;
 double doubleValue = (double)intValue;
 
 Swift:
 */
var intValuek : Int = 10
var doubleValuek : Double
doubleValue = Double(intValuek)
// 注意:Double()并不会修改intValue的值, 而是通过intValue的值生成一个临时的值赋值给doubleValue
print(intValuek)
print(doubleValue)

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: String = "\u{65}\u{301}"          // e 后面加上
// eAcute 是 é, combinedEAcute 是 é
print(eAcute, combinedEAcute, MemoryLayout.size(ofValue: eAcute),MemoryLayout.size(ofValue: combinedEAcute))

let combinedEAcute1: Character = "\u{65}"          // e 后面加上
let combinedEAcute2: Character = "\u{301}"          // e 后面加上
let tempstr = String([combinedEAcute1, combinedEAcute2])
print(combinedEAcute1, combinedEAcute2, tempstr, tempstr.count, tempstr[tempstr.startIndex], tempstr.startIndex)

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: String = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed 是 한, decomposed 是 한
print(precomposed, decomposed)

let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝
print(enclosedEAcute)

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 是 🇺🇸
print(regionalIndicatorForUS, regionalIndicatorForUS)

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// 打印输出“the number of characters in cafe is 4”

word += "\u{301}"    // 拼接一个重音，U+0301

print("the number of characters in \(word) is \(word.count)")
// 打印输出“the number of characters in café is 4”
for character in word {
    print(character)
}

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports.keys
