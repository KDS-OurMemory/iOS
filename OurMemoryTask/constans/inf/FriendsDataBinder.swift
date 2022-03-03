//
//  FriendsDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/21.
//

import Foundation
import UIKit

public protocol FriendsDataBinder {
    func getBirthday() -> String
    func getBirthdayOpen() -> Bool
    func getName() -> String
    func getProfileImage(block:@escaping (UIImage?) -> Void)
    func getSolar() -> Bool
    func getFriendStatus() -> FRIENDS_STATUS?
    func getIsSelected() -> Bool?
}
