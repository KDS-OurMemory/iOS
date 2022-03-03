//
//  AddFriendView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol AddFriendsView:ViewContract {

    func updateRecommendFriendList()
    func updateMyQR()
    func updateUserListAtSearchID()
    func updateUserListAtSearchName()
    func updateSelectTabIndex(idx:Int)
}
