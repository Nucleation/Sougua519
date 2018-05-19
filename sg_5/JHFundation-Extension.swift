//
//  JHFundation-Extension.swift
//  MultiWindow
//
//  Created by zhishen－mac on 2018/4/16.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
//数组添加removeObjectInArray方法
extension Array where Element: Equatable {
    mutating func removeObject(object:Element){
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    mutating func removeObjectInArray(array:[Element]){
        for object in array{
            self.removeObject(object: object)
        }
    }
}
