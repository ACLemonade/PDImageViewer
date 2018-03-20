//
//  DimensionConst.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/12.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class DimensionConst: NSObject {
    /// 全屏宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 全屏高度
    static let screenHeight = UIScreen.main.bounds.height
    /// tabbar切换视图控制器高度
    static let tabbarHeight = UtilsConst.isIPhoneX ? CGFloat(83.0) : CGFloat(49.0)
    /// 搜索视图高度
    static let searchBarHeight = CGFloat(45.0)
    /// 状态栏高度
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    /// 导航栏高度
    static let navigationBarHeight = CGFloat(44.0)
}


