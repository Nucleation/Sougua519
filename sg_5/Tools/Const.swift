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
//总接口
let postUrl = "http://192.168.10.125:10001"
//获取短信验证码
let ucenterGetSecurityCode = "\(postUrl)/app/ucenter/api/getAppUserSecurityCode"
//登陆
let userLogin = "\(postUrl)/app/ucenter/api/appUserLogin"
//注册
let userRegister = "\(postUrl)/app/ucenter/api/appUserRegister"
//获取图片分类
let picGetClassify = "\(postUrl)/app/picture/api/getClassify"
let picGetImgByClassify = "\(postUrl)/app/picture/api/getImgByClassify"
//获取小说分类
let noveGetCategorys = "\(postUrl)/app/novel/api/getCategorys"
//获取小说列表
let getNovelListByPage = "\(postUrl)/app/novel/api/getNovelListByPage"
//获取小说章节
let getNovelSection = "\(postUrl)/app/novel/api/getNovelSection"
//获取小说内容
let getNovelContent = "\(postUrl)/app/novel/api/getNovelContent"
//点赞
let commentLike = "\(postUrl)/app/comment/api/appCommentLike"
//举报
let commentReport = "\(postUrl)/app/comment/api/entry/appCommentReport"
//获取评论列表
let commentByType = "\(postUrl)/app/comment/api/getCommentByTypeId"
//添加评论
let addCommentUrl = "\(postUrl)/app/comment/api/entry/addComment"


