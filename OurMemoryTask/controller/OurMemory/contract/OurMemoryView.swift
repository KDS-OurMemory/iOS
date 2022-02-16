//
//  OurMemoryView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation

public protocol OurMemoryView:ViewContract {
    func setSearchBlock(searchCallback:@escaping (String) -> Void)
    func updateFriendList()
    func updateRoomList()
}
