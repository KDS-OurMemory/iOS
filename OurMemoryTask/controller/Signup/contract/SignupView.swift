//
//  SignupView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/16.
//

import Foundation

public protocol SignupView:ViewContract
{
    func updateResultAlert(user:UserDataBinder)
    func updateConfirmBtnState(state:Bool)
    func updateSolarBtn(isSolar:Bool)
    func updateBirthdayOpenBtn(isOpenBirthday:Bool)
    func updateName(name:String)
    func updateBirthday(birthday:String)
}
