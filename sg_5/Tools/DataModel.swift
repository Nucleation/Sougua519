//
//  DataModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var historyList = [Histroy]()
    
    override init(){
        super.init()
    }
    
    //保存数据
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(historyList, forKey: "historyList")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExists(atPath: path) {
            //读取文件数据
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            //通过归档时设置的关键字Checklist还原lists
            historyList = unarchiver.decodeObject(forKey: "historyList") as! Array
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/historyList.plist")
    }
}
class Histroy: NSObject, NSCoding {
    var his:String
    
    //构造方法
    required init(his:String="") {
        self.his = his
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.his = decoder.decodeObject(forKey: "His") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(his, forKey:"His")
    }
}
