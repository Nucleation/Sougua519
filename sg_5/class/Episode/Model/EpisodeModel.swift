//
//  EpisodeModel.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/4.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
import HandyJSON
class EpisodeModel: HandyJSON {
    var id: String = ""//编号
    var author: String = ""//作者
    var authorPortrait: String = ""//作者头像
    var content: String = ""//内容
    var contentImg: String = ""//内容图片URL （带图的段子才有）
    var title: String = ""//video 标题（视频段子才有）
    var videourl: String = ""//video地址（视频段子才有）
    var pic: String = ""//video图片地址（视频段子才有）
    var date: String = ""//段子发布日期
    var type: String = ""//段子类型
    var up: Int = 0//点赞 加
    var down: Int = 0//点赞 减
    var commentNum: Int = 0//评论
    var source: String = ""//段子来源
    var mark: String = ""//标记：1 纯文本 2带图的 3视频
    var createTime: String = ""//创建时间
    var del: String = ""//删除标记
    public required init() {}
}
