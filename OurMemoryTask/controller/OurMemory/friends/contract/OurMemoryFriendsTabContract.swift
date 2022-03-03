//
//  OurMemoryContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation


public protocol OurMemoryFriendsTabContract:BaseCollectionAdapterContract {
    
    func switchRoomsTab()
 
    func activeFriendsTab()
    func updateSearchView()
}
