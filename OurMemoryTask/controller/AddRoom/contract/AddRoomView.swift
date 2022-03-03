//
//  AddRoomView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol AddRoomView:ViewContract {
    
    func updateSelectedUserDatas(datas:[FriendsDataBinder])
    func updateSelectedUserCnt(cnt:Int)
}
