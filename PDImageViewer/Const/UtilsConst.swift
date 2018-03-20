//
//  UtilsConst.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/13.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class UtilsConst: NSObject {
    // MARK: - 设备信息
    
    /// 当前app信息
    static let kAppInfoDictionary = Bundle.main.infoDictionary
    /// 当前app版本号
    static let kAppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
    /// BundleID
    static let kAppBundleID = Bundle.main.infoDictionary!["CFBundleIdentifier"]
    /// 获取设备系统号
    static let kSystemVersion = UIDevice.current.systemVersion
    /// iPhone设备
    static let isIPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
    /// iPad设备
    static let isIPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)
    /// 是否为iPhone4
    static let isIPhone4 = UIScreen.main.bounds.size == CGSize.init(width: 320, height: 480) ? true : false
    /// 是否为iPhone4S
    static let isIPhone4S = isIPhone4
    /// 是否为iPhone5
    static let isIPhone5 = UIScreen.main.bounds.size == CGSize.init(width: 320, height: 568) ? true : false
    /// 是否为iPhone5S
    static let isIPhone5S = isIPhone5
    /// 是否为iPhone5C
    static let isIPhone5C = isIPhone5
    /// 是否为iPhoneSE
    static let isIPhoneSE = isIPhone5
    /// 是否为iPhone6
    static let isIPhone6 = UIScreen.main.bounds.size == CGSize.init(width: 375, height: 667) ? true : false
    /// 是否为iPhone7
    static let isIPhone7 = isIPhone6
    /// 是否为iPhone8
    static let isIPhone8 = isIPhone6
    /// 是否为iPhone6P
    static let isIPhone6P = UIScreen.main.bounds.size == CGSize.init(width: 414, height: 736) ? true : false
    /// 是否为iPhone6SP
    static let isIPhone6SP = isIPhone6P
    /// 是否为iPhone7P
    static let isIPhone7P = isIPhone6P
    /// 是否为iPhone8P
    static let isIPhone8P = isIPhone6P
    /// 是否为iPhoneX
    static let isIPhoneX = UIScreen.main.bounds.size == CGSize.init(width: 375, height: 812) ? true : false
}
extension UIDevice {
    /// 设备具体名称
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
}

// MARK: - 时间格式
enum TimeFormat: String
{
    case format_default            = "yyyy-MM-dd HH:mm:ss"
    case format_yyMdHm             = "yy-MM-dd HH:mm"
    case format_yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case format_yMd                = "yyyy-MM-dd"
    case format_MdHms              = "MM-dd HH:mm:ss"
    case format_MdHm               = "MM-dd HH:mm"
    case format_Hms                = "HH:mm:ss"
    case format_Hm                 = "HH:mm"
    case format_Md                 = "MM-dd"
    case format_yyMd               = "yy-MM-dd"
    case format_YYMMdd             = "yyyyMMdd"
    case format_yyyyMdHms          = "yyyyMMddHHmmss"
    case format_yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case format_yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case format_yMdWithSlash       = "yyyy/MM/dd"
    case format_yM                 = "yyyy-MM"
    case format_yMdChangeSeparator = "yyyy.MM.dd"
}

