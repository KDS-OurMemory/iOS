//
//  LoginCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import UIKit
import KakaoSDKUser

class LoginCtl: BaseCtl {
 
    let loginModel = LoginModel()
    let appSaveDataModel = AppSaveDataModel()
    
    override func __initWithData__(data: Any?) {
        loginModel.initWithCallback(context: self) { p1, p2 in
            switch p1 {
            case .SUCCESS_CASE:
                self.callShowNextVC(view: .NEXTVIEW_MYMEMORY, data: nil)
                break
            case .SIGNUP_CASE:
                self.callShowNextVC(view: .NEXTVIEW_SIGNUP, data: p2)
                break
            case .FAILE_CASE:
                self.view.showAlertMsgWithTitle(title: "", msg: "소셜로그인에 실패하였습니다. 재시도 해주시길 바랍니다.")
                break
            default:
                break
            }
        }
    }
    
    // MARK: private
    override func callShowNextVC(view: NEXTVIEW, data: Any?) {
        switch view {
        case .NEXTVIEW_SIGNUP:
            self.view.showNextVC(vc:.NEXTVIEW_SIGNUP, data: data)
            break
//        case .NEXTVIEW_MAIN:
//            self.view.showNextVC(vc:.NEXTVIEW_MAIN, data: nil)
//            break
        case .NEXTVIEW_MYMEMORY:
            self.view.showNextVC(vc: .NEXTVIEW_MYMEMORY, data: nil)
            break
        default:
            break
        }
    }

    override func onTaskError(ourMemoryErr: OurMemoryErrorData) {
        switch ourMemoryErr.errorCode {
        case NETRESULTCODE.UNKNOWNSIGNEDUSER_ERROR:
            self.loginModel.startSignupProcess()
            break
        default:
            break
        }
    }
}

extension LoginCtl:LoginContract {
    
    func openUrlForSnsLogin(url:URL) -> Bool {
        return self.loginModel.openUrlForSnsLogin(url: url)
    }
    
    func startKakaoLoginProccess() {
        self.loginModel.setSnsType(snsType: .KAKAO)
        KaKaoLoginWrapper.shared.initWithKakaoSDK()
        KaKaoLoginWrapper.shared.tryKakaoLogin { user in
            self.loginModel.setKakaoUserData(user: user)
        }
    }
    
    func startGoogleLoginProccess() {
        
    }
    
    func startNaverLoginProccess() {
        
    }
}
