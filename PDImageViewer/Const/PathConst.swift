//
//  PathConst.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/13.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import Foundation

class PathConst: NSObject {
    /// Home路径
    static let home = NSHomeDirectory()
    /// Tmp路径
    static let temporary = NSTemporaryDirectory()
    /// Document路径
    static let document = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    /// Cache路径
    static let cache = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    /// 用户信息plist路径
    static let userDataPlist = PathConst.document! + "/UserData.plist"
    /// 缓存主目录
    static let fileCachesDirectory = PathConst.cache! + "/file/download/"
    /// plist文件存储目录
    static let magzine = PathConst.cache! + "/file/plist"
    /// 小视频存储目录
    static let video = PathConst.cache! + "/file/video"
}



