//
//  OurMemoryContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol OurMemoryContract:DataContract {
    func switchFriendListTab()
    func switchRoomListTab()
    
    func actionSearchBtn(sender:UIButton)
    func actionAddFriendBtn(sender:UIButton)
    func actionSettingsBtn(sender:UIButton)
}
