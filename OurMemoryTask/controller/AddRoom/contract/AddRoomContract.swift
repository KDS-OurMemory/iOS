//
//  AddRoomContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol AddRoomContract:BaseCollectionAdapterContract {
    
    func removeSelectedUserItemAtIndex(idx:Int)
    func actionConfirmBtn()
}
