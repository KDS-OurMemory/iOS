//
//  AddFriendsCollectionCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/22.
//

import UIKit
import OurMemoryTask

class AddFriendsCollectionCell: BaseCollectionViewCell {

    @IBOutlet weak var friendsProfileImage: UIImageView!
    @IBOutlet weak var friendsNameLbl: UILabel!
    @IBOutlet weak var tryAddFriendsBtn: UIButton!
    
    func setTryAddFriendsBtnBlock(block:@escaping (Bool) -> Void) {
        tryAddFriendsBtn.addAction { p1 in
            block(p1.isSelected)
        }
        tryAddFriendsBtn.titleLabel?.font = .systemFont(ofSize: 8)
        tryAddFriendsBtn.setTitleColor(.blue, for: .normal)
    }
    
    func setData(data:FriendsDataBinder) {
        friendsNameLbl.text = data.getName()
        
        data.getProfileImage { p1 in
            self.friendsProfileImage.image = p1
        }
        
        if let status = data.getFriendStatus() {
            switch status {
            case .BLOCK,.unowned:
                tryAddFriendsBtn.setTitle("친구 추가", for: .normal)
                break
            case .FRIEND:
                tryAddFriendsBtn.setTitle("이미 친구입니다.", for: .normal)
                tryAddFriendsBtn.isUserInteractionEnabled = false
                break
            case .REQUESTED:
                tryAddFriendsBtn.setTitle("친구 수락", for: .normal)
                tryAddFriendsBtn.setImage(nil, for: .normal)
                break
            case .WAIT:
                tryAddFriendsBtn.setTitle("친구 요청 중", for: .normal)
                break
            }
        }
    }
}
