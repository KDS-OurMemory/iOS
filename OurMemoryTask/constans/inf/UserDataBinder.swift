//
//  UserDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/25.
//

import Foundation
import UIKit

public protocol UserDataBinder {
    func getName() -> String
    
    func getBirthday() -> String?
    
    func getBirthdayOpen() -> Bool?
    
    func getIsSolar() -> Bool?
    
    func getProfileImage() -> UIImage?
    
    func getUserId() -> String // NOTICE: userId가 표출되는것이 맞는것인가
    
    func getIsPush() ->Bool
    
    func getSnsType() -> String
    
}
