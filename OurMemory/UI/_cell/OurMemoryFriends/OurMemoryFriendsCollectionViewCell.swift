//
//  OurMemoryFriendsCell.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

class OurMemoryFriendsCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var friendsProfileImg: UIImageView!
    @IBOutlet weak var friendsNameLbl: UILabel!
    
    
    func setData(data:FriendsDataBinder) {
        friendsNameLbl.text = data.getName()
        
        data.getProfileImage { p1 in
            self.friendsProfileImg.image = p1
        }
    }
}
