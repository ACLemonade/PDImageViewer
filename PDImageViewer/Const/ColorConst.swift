//
//  ColorConst.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/12.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class ColorConst: NSObject {
    // 普通RGB颜色
    static func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    // 普通RGB颜色,默认不透明
    static func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return RGBA(r: r, g: g, b: b, a: 1.0)
    }
    // 十六进制颜色
    static func colorConversion(rgbValue: String, alpha: CGFloat) -> UIColor {
        var cStr: String = rgbValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cStr.hasSuffix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = cStr.substring(from: index)
        }
        // 格式不对,返回黑色
        if cStr.count != 6 {
            return UIColor.black
        }
        // 截取红色16进制值
        let rRange = cStr.startIndex..<cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = cStr.substring(with: rRange)
        // 截取绿色16进制值
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2)..<cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = cStr.substring(with: gRange)
        // 截取蓝色16进制值
        let bRange = cStr.index(cStr.endIndex, offsetBy: -2)..<cStr.endIndex
        let bStr = cStr.substring(with: bRange)
        
        return UIColor.init(red: CGFloat(changeToInt(numStr: rStr)) / 255, green: CGFloat(changeToInt(numStr: gStr)) / 255, blue: CGFloat(changeToInt(numStr: bStr)) / 255, alpha: alpha)
        
    }
    private static func changeToInt(numStr:String) -> Int {
        let str = numStr.uppercased()
        var sum = 0
        for i in str.utf8 {
            //0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            if i >= 65 {
                //A~Z 从65开始，但初始值为10
                sum -= 7
            }
        }
        return sum
    }
}




