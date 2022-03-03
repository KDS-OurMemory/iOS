//
//  SelectedUserView.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class SelectedUserView: BaseView {

    let closeBtn:UIButton = UIButton()
    let userProfileImage:UIImageView = UIImageView()
    let userNameLbl:UILabel = UILabel()
    
    override func prepareViews() {
        let viewSize = CGSize(width: 60, height: 60)
        let profileSize = CGSize(width: viewSize.width * 0.8, height: viewSize.height * 0.6)
        let profileImgX = (viewSize.width - profileSize.width ) * 0.5
        let nameLblSize = CGSize(width: viewSize.width, height: viewSize.height * 0.4)
        let closeBtnSize = CGSize(width: viewSize.width * 0.2, height: viewSize.height * 0.2)
        
        self.addSubview(userProfileImage)
        self.addSubview(userNameLbl)
        self.addSubview(closeBtn)
        
        self.frame.size = viewSize
        userProfileImage.frame = CGRect(x: profileImgX, y: 0, width: profileSize.width, height: profileSize.height)
        userNameLbl.frame = CGRect(x: 0, y: profileSize.height, width: nameLblSize.width, height: nameLblSize.height)
        closeBtn.frame = CGRect(x: viewSize.width-closeBtnSize.width, y: 0, width: closeBtnSize.width, height: closeBtnSize.height)
        
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    func setData(data:FriendsDataBinder) {
        data.getProfileImage(block: { p1 in
            self.userProfileImage.image = p1
        })
        
        self.userNameLbl.text = data.getName()
    }
    
    func setCloseBtnBlock(block:@escaping () -> Void) {
        closeBtn.addAction { p1 in
            block()
        }
    }

}
