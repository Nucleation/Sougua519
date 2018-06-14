//
//  DataModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/14.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var histList = [History]()
    
    override init(){
        super.init()
    }
    
    //保存数据
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(histList, forKey: "History")
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
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data! as Data)
            //通过归档时设置的关键字Checklist还原lists
            histList = unarchiver.decodeObject(forKey: "History") as! Array
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentationDirectory,FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDirectory:String = (paths.first)!
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().appending("history.plist")
    }
}
class History: NSObject {
    var history:String
    
    //构造方法
    init(history:String=""){
        self.history = history
        super.init()
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.history=aDecoder.decodeObject(forKey: "History") as! String
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encode(history,forKey:"History")
    }
}
