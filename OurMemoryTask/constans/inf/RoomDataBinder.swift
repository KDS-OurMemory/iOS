//
//  RoomDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/23.
//

import Foundation

public protocol RoomDataBinder {
    func getUserCnt() -> Int
    func getName() -> String
}