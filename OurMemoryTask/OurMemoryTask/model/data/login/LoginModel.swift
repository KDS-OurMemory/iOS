//
//  LoginModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/04.
//

import UIKit

class LoginModel: NSObject {

    let autoLoginNetModel = AutoLoginNetModel()
    let loginNetModel = LoginNetModel()
    
    var currentSnsType:SNSTYPE?
    var userDataCallback:((LOGINNETCASE)-> Void)!
    
    func initWithCallback(callback: @escaping (LOGINNETCASE)-> Void ) {
    
        self.autoLoginNetModel.initWithCallback { validCase in
            switch validCase {
            case .KNOWN_CASE:
                self.userDataCallback(.KNOWN_CASE)
                break
            case .NOTCONNECTNET_CASE:
                self.userDataCallback(.NOTCONNECTNET_CASE)
                break
            case .REQUESTERROR_CASE:
                self.userDataCallback(.REQUESTERROR_CASE)
                break
            case .SUCCESS_CASE:
                self.userDataCallback(.SUCCESS_CASE)
                break
            case .FAILE_CASE:
                self.userDataCallback(.FAILE_CASE)
                break
            }
        }
        
        self.loginNetModel.initWithCallback { validCase in
            switch validCase {
            case .KNOWN_CASE:
                self.userDataCallback(.KNOWN_CASE)
                break
            case .NOTCONNECTNET_CASE:
                self.userDataCallback(.NOTCONNECTNET_CASE)
                break
            case .REQUESTERROR_CASE:
                self.userDataCallback(.REQUESTERROR_CASE)
                break
            case .SUCCESS_CASE:
                self.userDataCallback(.SUCCESS_CASE)
                break
            case .FAILE_CASE:
                self.userDataCallback(.FAILE_CASE)
                break
            }
        }
        
        self.userDataCallback = callback
    }
    
    func setSnsType(type:SNSTYPE) {
        self.currentSnsType = type
    }
    
    func getSnsType() -> SNSTYPE? {
        return self.currentSnsType != nil ? self.currentSnsType:nil
    }
    
    func tryAutoLoginRequest() {
        self.autoLoginNetModel.tryAutoLoginRequest()
    }
    
    func tryLoginRequest() {
        self.loginNetModel.tryLoginRequest()
    }
    
}
