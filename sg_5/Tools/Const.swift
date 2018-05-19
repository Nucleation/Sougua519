//
//  Const.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let postUrl = "http://192.168.10.125:10001"

let ucenterGetSecurityCode = "\(postUrl)/app/ucenter/api/getAppUserSecurityCode"
let picGetClassify = "\(postUrl)/app/picture/api/getClassify"
let picGetImgByClassify = "\(postUrl)/app/picture/api/getImgByClassify"
let noveGetCategorys = "\(postUrl)/app/novel/api/getCategorys"
let getNovelListByPage = "\(postUrl)/app/novel/api/getNovelListByPage"
let getNovelSection = "\(postUrl)/app/novel/api/getNovelSection"
let getNovelContent = "\(postUrl)/app/novel/api/getNovelContent"


