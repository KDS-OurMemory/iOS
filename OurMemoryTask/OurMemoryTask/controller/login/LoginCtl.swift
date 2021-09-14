//
//  LoginCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import UIKit

class LoginCtl: BaseCtl {
 
    let loginModel = LoginModel()
    let appSaveDataModel = AppSaveDataModel()
    
    override func __init__() {
        loginModel.initWithCallback { valideCase in
            switch valideCase
            {
            case .KNOWN_CASE:
                break
            case .NOTCONNECTNET_CASE:
                break
            case .REQUESTERROR_CASE:
                self.startLoginProcess()
                break
            case .SUCCESS_CASE:
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_MAIN)
                break
            case .FAILE_CASE:
                self.startLoginProcess()
                break
            }
        }
    }
    
    // MARK: private
    
    func callShowNextVC(vc:NEXTVIEW) {
        DispatchQueue.main.async {
            switch vc {
            case .NEXTVIEW_LOGIN:
                self.view.showNEXTVC(vc:.NEXTVIEW_LOGIN, data: nil)
                break
            case .NEXTVIEW_MAIN:
                self.view.showNEXTVC(vc:.NEXTVIEW_MAIN, data: nil)
                break
            default:
                break
            }
        }
    }
    
    func startLoginProcess() {
        if let snsType = self.loginModel.getSnsType() {
            switch snsType {
            case .KAKAO:
                if let view = self.view as? LoginView, let snsType = self.loginModel.getSnsType() {
                    view.showSignUpView(snsType:snsType)
                }
                break
            case .GOOGLE:
                break
            case .NAVER:
                break
                
            }
        }
    }
}

extension LoginCtl:LoginContract {
    func tryAutoLoginRequestLogin(type:SNSTYPE) {
        self.loginModel.setSnsType(type: type)
        self.loginModel.tryAutoLoginRequest()
    }
    
    func tryLoginRequest() {
        self.loginModel.tryLoginRequest()
    }
}
