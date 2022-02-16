//
//  ViewConst.swift
//  OurMemory
//
//  Created by 이승기 on 2022/01/27.
//

import Foundation
import UIKit

struct TabItems: Hashable,OptionSet {
    
    let rawValue: UInt
    
    static let home = TabItems(rawValue:1)
    static let category = (TabItems(rawValue: TabItems.home.rawValue << 1))
    static let myMemory = (TabItems(rawValue: TabItems.home.rawValue << 2))
    static let ourMemory = (TabItems(rawValue: TabItems.home.rawValue << 3))
    static let myProfile = (TabItems(rawValue: TabItems.home.rawValue << 4))
    static let schdule = (TabItems(rawValue: TabItems.home.rawValue << 5))
    static let frieand = (TabItems(rawValue: TabItems.home.rawValue << 6))
    static let todoList = (TabItems(rawValue: TabItems.home.rawValue << 7))
    static let butkitList = (TabItems(rawValue: TabItems.home.rawValue << 8))
    static let noti = (TabItems(rawValue: TabItems.home.rawValue << 9))
}

let mainWidth = UIScreen.main.bounds.size.width
let mainHeight = UIScreen.main.bounds.size.height
let topViewHeight = 60.0
let tabbarHeight = 70.0
