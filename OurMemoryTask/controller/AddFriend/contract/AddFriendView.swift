//
//  AddFriendView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol AddFriendView:ViewContract {

    func updateRecommendFriendList()
    func updateMyQR()
    func updateIDSearchBlock(searchCallback:@escaping (String) -> Void)
    func updateUserListAtSearchID()
    func updateUserListAtSearchName()
}
