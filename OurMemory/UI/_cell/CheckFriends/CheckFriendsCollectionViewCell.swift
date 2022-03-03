//
//  CheckFriendsCollectionViewCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class CheckFriendsCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var friendsProfileImage: UIImageView!
    @IBOutlet weak var friendsNameLbl: UILabel!
    @IBOutlet weak var tryCheckFriendsBtn: UIButton!
    
  
    func setTryCheckFriendsBtnBlock(block:@escaping (Bool) -> Void) {
        tryCheckFriendsBtn.addAction { p1 in
            block(p1.isSelected)
        }
    }
    
    func setData(data:FriendsDataBinder) {
        friendsNameLbl.text = data.getName()
        
        data.getProfileImage(block: { p1 in
            self.friendsProfileImage.image = p1
        })
        if let isSelected = data.getIsSelected() {
            tryCheckFriendsBtn.isSelected = isSelected
        }
        
           
    }

}
