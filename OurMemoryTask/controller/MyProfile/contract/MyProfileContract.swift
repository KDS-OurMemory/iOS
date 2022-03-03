//
//  MyProfileContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol MyProfileContract:BasePHPickerControllerAdapterContract {
    func actionProfileImage(imageSize:CGSize)
    func actionSwitchPush(state:Bool)
    func actionLogoutBtn()
}
