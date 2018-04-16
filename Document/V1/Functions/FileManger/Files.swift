//
//  Files.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/13.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** Habit 对象存储管理对象对象 */
let habit_files = Files(folder: "Habit")

/** 文件管理系统 */
class Files {
    
    // MARK: - Path
    
    /** 文件夹路径 */
    var folder: String
    /** 文件路径 */
    func file(_ name: String) -> String {
        return "\(folder)/\(name).obj"
    }
    
    // MARK: - Init
    
    /** 初始化时会创建文件夹 */
    init(folder: String) {
        self.folder = "\(NSHomeDirectory())/Documents/\(folder)"
        do {
            try FileManager.default.createDirectory(at: URL(fileURLWithPath: self.folder), withIntermediateDirectories: true, attributes: nil)
        } catch { }
    }
    
    
    // MARK: - Get
    
    /** 获取该文件夹下的所有对象 */
    func objects() -> [Data] {
        var datas = [Data]()
        if let subs = FileManager.default.subpaths(atPath: folder) {
            for sub in subs {
                if sub.hasSuffix(".obj") && !sub.contains("/") {
                    if let data = FileManager.default.contents(atPath: "\(folder)/\(sub)") {
                        datas.append(data)
                    }
                }
            }
        }
        return datas
    }
    
    /** 读取特定对象 */
    func read(_ name: String) -> Data? {
        return FileManager.default.contents(atPath: file(name))
    }
    
    // MARK: - Set
    
    /** 保存对象 */
    @discardableResult
    func save(_ name: String, _ obj: Json_Protocol) -> Bool {
        if let data = obj.json() {
            do {
                try data.write(
                    to: URL(fileURLWithPath: file(name))
                )
                return true
            } catch { }
        }
        return false
    }
    
    /** 删除对象 */
    @discardableResult
    func delete(_ name: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: file(name))
            return true
        } catch { }
        return false
    }
}


