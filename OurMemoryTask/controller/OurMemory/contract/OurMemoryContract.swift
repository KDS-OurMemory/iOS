//
//  OurMemoryContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import Foundation
import UIKit

public protocol OurMemoryContract:DataContract {
    func actionSearchBtn(sender:UIButton)
    func actionAddFriendAndAddRoomBtn(sender:UIButton)
    func actionSettingsBtn(sender:UIButton)
    func reloadView()
    func switchFriendsTab()
    func switchRoomsTab()
}
