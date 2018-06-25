//
//  Const.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
enum ContentType: String {
    case Novel = "7"
    case Picture = "3"
    case News = "1"
    case Episode = "5"
}
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
//总接口
//let postUrl = "http://47.95.244.69:8086"
let postUrl = "http://api.soogua.cn/"

//let postUrl = "http://192.168.10.123:10001"
//获取短信验证码
let ucenterGetSecurityCode = "\(postUrl)/app/ucenter/api/getAppUserSecurityCode"
//登陆
let userLogin = "\(postUrl)/app/ucenter/api/appUserLogin"
//注册
let userRegister = "\(postUrl)/app/ucenter/api/appUserRegister"
//忘记密码，重置
let resetPwdUrl = "\(postUrl)/app/ucenter/api/resetPwd"

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
let commentReportUrl = "\(postUrl)/app/comment/api/entry/appCommentReport"
//获取评论列表
let commentByType = "\(postUrl)/app/comment/api/getCommentByTypeId"
//添加评论
let addCommentUrl = "\(postUrl)/app/comment/api/entry/addComment"
//首页新闻推荐
let getNewsUrl = "\(postUrl)/app/novel/api/getRecommendListByPage"
//判断用户是否添加过小说到书架
let checkNovelShelfUrl = "\(postUrl)/app/novel/api/checkNovelShelf"
//获取书架列表
let getNovelShelfListUrl = "\(postUrl)/app/novel/api/entry/getShelfList"
//根据id删除小说
let deleteNovelShelfUrl = "\(postUrl)/app/novel/api/entry/deleteShelf"
//增加小说
let addNovelShelfUrl = "\(postUrl)/app/novel/api/entry/addShelf"
//获取新闻类型
let getNewsTypeListUrl = "\(postUrl)/app/novel/api/getNewsTypeList"
//获取新闻列表
let getNewsListByTypeUrl = "\(postUrl)/app/novel/api/getNewsListByTypePage"
//获取段子接口
let getEpisodeUrl = "\(postUrl)/app/picture/api/getEpisode"
//段子点赞
let pictureUpUrl = "\(postUrl)/app/picture/api/up"
//段子差评
let pictureDownUrl = "\(postUrl)/app/picture/api/down"
//段子评论点赞
let commentUpUrl = "\(postUrl)/app/comment/api/up"
//
let UpHeadImageUrl = "\(postUrl)/app/ucenter/api/entry/updateAppUserHeadImg"
let UpnewLickUrl = "\(postUrl)/app/novel/api/getNewsLike"
//添加收藏
let addCollectUrl = "\(postUrl)/app/comment/api/entry/addCollect"
let cancleCollectUrl = "\(postUrl)/app/comment/api/entry/cancleCollect"
let getCollectsUrl = "\(postUrl)/app/comment/api/entry/getCollects"
let getIsCollectUrl = "\(postUrl)/app/comment/api/getIsCollect"
let getVideoByIDUrl = "\(postUrl)/app/novel/api/getVideoById"
let getEpisodeByIDUrl = "\(postUrl)/app/picture/api/getEpisodeById"
let getNewsByIDUrl = "\(postUrl)/app/novel/api/getNewsById"
let getAboutUSDataUrl = "\(postUrl)app/content/pc/getAdProdictForPC"

