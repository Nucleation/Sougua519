//
//  EpisodeCommentTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/6/5.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit
protocol EpisodeCommentTableViewCellDelegate {
    func addTooleUP()
}

class EpisodeCommentTableViewCell: UITableViewCell {
    var model = NovelCommentModel(){
        didSet {
            self.upBtn.isEnabled = true
            userNameLab.text = model.fromMobile
            commentLab.text = model.content
            timeLab.text = model.createDate
            upBtn.setTitle(String(model.upCount), for: .normal)
            userIconImg.kf.setImage(with: URL(string: model.fromHeadUrl))
        }
    }
    var episodeModel:EpisodeModel?
    
    @IBOutlet weak var userIconImg: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var upBtn: UIButton!
    var delegate: EpisodeCommentTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func upBtnClick(_ sender: Any) {
        model.upCount += 1
        self.upBtn.isEnabled = false
        self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
        self.upBtn.setTitle(String(model.upCount), for: .normal)
        //#MARK: -- 交给父视图处理
        addTootleUP()
        self.upWithIdAndMark(id: model.id)
    }
    func upWithIdAndMark(id: String){
        let timeInterval: Int = Int(Date().timeIntervalSince1970 * 1000)
        let dic: Dictionary<String, Any> = ["timestamp":String(timeInterval),"id":id]
        let parData = dic.toParameterDic()
        NetworkTool.requestData(.post, URLString: commentUpUrl, parameters: parData) { (json) in
            if json["code"] == "1" {
                self.makeToast(json["msg"].stringValue)
            }
        }
    }
    func addTootleUP(){
        if delegate != nil{
            delegate?.addTooleUP()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
