//
//  LoginModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/04.
//

import UIKit
import KakaoSDKUser

class LoginModel: NSObject {

    let loginNetModel = LoginNetModel()
    var context:DataContract!
    var currentSnsType:SNSTYPE?
    var userSnsId:Int64?
    var callback:((LOGINNETCASE,Any?)-> Void)!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var userData:signUpInputUserData?
    
    func initWithCallback(context:DataContract ,callback: @escaping (LOGINNETCASE,Any?)-> Void) {
        self.callback = callback
        self.context = context
        
        if let snsType = saveDataModel.useSnsTypeData(),let snsId = saveDataModel.useSnsIDData() {
            loginNetModel.setRequestQueryParams(params: [
                "snsId":snsId,
                "snsType":snsType
            ])
            currentSnsType = SNSTYPE.init(rawValue: Int8(snsType))
            userSnsId = Int64(snsId)
            self.tryLoginRequest(context: context)
        }
        
        
        
    }
    
    func setKakaoUserData(user:User) {
        self.currentSnsType = .KAKAO
        if let kakaoAccount = user.kakaoAccount {
            
            if let id = user.id {
                var nickname = ""
                var birthday = ""
                var birthdayOpen = false
                var solar:BirthdayType = .Solar
                
                if let bday = kakaoAccount.birthday {
                    birthday = bday
                }
                if let isSolar = kakaoAccount.birthdayType {
                    solar = isSolar
                }
                if let bdayOpen = kakaoAccount.birthdayNeedsAgreement {
                    birthdayOpen = bdayOpen
                }
                
                if let profile = kakaoAccount.profile, let name = profile.nickname{
                    nickname = name
                }
                userData = signUpInputUserData(name: nickname, birthday: birthday, birthdayOpen: birthdayOpen, solar: (solar == .Solar ? true: false), snsId: "\(id)", snsType: .KAKAO)
                self.setSnsData(id: id, type: .KAKAO)
            }
        }
        
    }
    
    func setSnsType(snsType:SNSTYPE) {
        self.currentSnsType = snsType
    }
    
    func startSignupProcess() {
        if let userData = userData {
            self.callback(.SIGNUP_CASE,userData)
        }else {
            sharedUserDataModel.clearData()
            self.disconnectSnsLogin()
            self.callback(.FAILE_CASE,nil)
        }
    }
    
    func disconnectSnsLogin() {
        switch self.currentSnsType {
        case .UNOWNED:
            break
        case .KAKAO:
            KaKaoLoginWrapper.shared.dissConnectionKakao()
            break
        case .NAVER:
            break
        case .GOOGLE:
            break
        case .none:
            break
        }
    }
    
    func openUrlForSnsLogin(url:URL) -> Bool {
        switch self.currentSnsType {
        case .UNOWNED:
            break
        case .KAKAO:
            return KaKaoLoginWrapper.shared.isKakaoAcountLoginCallBack(url: url)
        case .NAVER:
            break
        case .GOOGLE:
            break
        case .none:
            break
        }
        return false
    }
    
    func setSnsData(id:Int64,type:SNSTYPE) {
        self.userSnsId = id
        self.currentSnsType = type
        if let snsId = self.userSnsId, let snsType = self.currentSnsType {
            loginNetModel.setRequestQueryParams(params: [
                "snsId":snsId,
                "snsType":snsType.rawValue
            ])
            self.tryLoginRequest(context: self.context)
        }
    }
    
    func getSnsType() -> SNSTYPE? {
        return self.currentSnsType != nil ? self.currentSnsType:nil
    }
    
    fileprivate func tryLoginRequest(context:DataContract) {
        loginNetModel.reqeustRestFulApi(context: context) { (data:Result<json<userData>,Error>) in
            switch(data) {
            case .success(let responseData):
                if let response = responseData.response {
                    let userData = response
                    self.sharedUserDataModel.saveUserData(userData: userData)
                    self.callback(.SUCCESS_CASE,nil)
                }
                break
            default:
                break
            }
        }
    }
    
}
