//
//  OurMemoryView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import Foundation

public protocol OurMemoryView:TabbarContract {
    func updateSearchView()
    func activeRoomsTabView()
    func activeFriendsTabView()
}
