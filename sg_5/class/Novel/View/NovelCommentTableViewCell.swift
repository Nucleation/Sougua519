//
//  NovelCommentTableViewCell.swift
//  sg_5
//
//  Created by zhishen－mac on 2018/5/22.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class NovelCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var userIconImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var upBtn: UIButton!
    
    var comment = NovelCommentModel(){
        didSet {
            self.userName.text = comment.fromMobile
            self.commentLab.text = comment.content
            self.timeLab.text = comment.createDate
            self.upBtn.setTitle("\(comment.upCount)", for: .normal)
            if comment.fromHeadUrl == ""{
                userIconImg.image = UIImage(named: "userIMG")
            }else{
                userIconImg.kf.setImage(with: URL(string: comment.fromHeadUrl))
            }
        }
    }

    @IBAction func upBtnClick(_ sender: Any) {
        comment.upCount += 1
        self.upBtn.isEnabled = false
        self.upBtn.setImage(UIImage(named: "dianzan2"), for: .normal)
        self.upBtn.setTitle(String(comment.upCount), for: .normal)
        self.upWithIdAndMark(id: comment.id)
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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userIconImg.layer.cornerRadius = 25
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
