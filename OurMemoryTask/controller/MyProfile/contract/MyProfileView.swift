//
//  MyProfileView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol MyProfileView:TabbarContract {
    func updateProfileData(profileData:UserDataBinder)
    func updateProfileImage(profileImg:UIImage)
}
