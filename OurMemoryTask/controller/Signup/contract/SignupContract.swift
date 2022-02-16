//
//  SignupContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/16.
//

import Foundation
import UIKit

public protocol SignupContract:BaseDatePickerAdapterContract {
    
    func setName(name:String)
    
    func disconnectSnsLogin()
    func actionCancelBtn(sender:UIButton)
    func actionConfirmBtn(sender:UIButton)
    func actionBirthdayOpenBtn(sender:UIButton)
    func actionBirthdayCloseBtn(sender:UIButton)
    func actionSolarBtn(sender:UIButton)
    func actionLunarBtn(sender:UIButton)
}
