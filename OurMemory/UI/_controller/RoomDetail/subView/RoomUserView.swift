//
//  RoomUserView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/15.
//

import UIKit

class RoomUserView: BaseView {

    let profileBtn:UIButton = UIButton()
    let userIdLbl:UILabel = UILabel()
    let userBtn:UIButton = UIButton()
    
    override func prepareViews() {
        let viewHeight = 60.0
        self.frame = CGRect(x: 0, y: 0, width: mainWidth, height: viewHeight)
        self.addSubview(userIdLbl)
        self.addSubview(profileBtn)
        self.addSubview(userBtn)
        
        self.profileBtn.frame = CGRect(x: 0, y: 0, width: viewHeight, height: viewHeight)
        self.userIdLbl.frame = CGRect(x: viewHeight+5, y: 0, width: mainWidth-viewHeight, height: viewHeight)
        self.userBtn.frame = CGRect(x: viewHeight+5, y: 0, width: mainWidth-viewHeight, height: viewHeight)
        
        self.profileBtn.layer.cornerRadius = viewHeight/2
        self.profileBtn.imageView?.layer.cornerRadius = viewHeight/2
        self.userIdLbl.textColor = .black
        
        self.profileBtn.setImage(UIImage.init(systemName: "person.circle"), for: .normal)
    }
    
    func setProfileImg(img:UIImage) {
        self.profileBtn.setImage(img, for: .normal)
    }
    
    func setId(id:String) {
        self.userIdLbl.text = id
    }
    
    func clickProfileBlock(block:@escaping (BaseView) -> Void) {
        self.profileBtn.addAction { p1 in
            block(self)
        }
    }
    
    func clickUserBlock(block:@escaping (BaseView) -> Void) {
        self.userBtn.addAction { p1 in
            block(self)
        }
    }

}
