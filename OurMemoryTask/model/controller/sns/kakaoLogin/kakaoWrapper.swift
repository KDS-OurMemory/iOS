//
//  KaKaoLoginWrapper.swift
//  snsWrapper
//
//  Created by 이승기 on 2021/03/18.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KaKaoLoginWrapper: NSObject {

    public static let shared:KaKaoLoginWrapper = KaKaoLoginWrapper()
    let appSaveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserData = SharedUserDataModel.sharedUserData
    
    override init() {
        super.init()
        
    }
    
    func initWithKakaoSDK() {
        
//        KakaoSDKCommon.initSDK(appKey: "6c16bd68b5f471add256f23fd0f492d2")
        KakaoSDKCommon.KakaoSDK.initSDK(appKey: "6c16bd68b5f471add256f23fd0f492d2")
        
    }
    
    func hasToken() -> Bool{
        return AuthApi.hasToken()
    }
    
    func getUserData() -> User? {
        var userData:User?
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            }else {
                userData = user
            }
        }
        
        if let data = userData {
            return data
        }
        return nil
    }
    
    func isKakaoLogOut() -> Bool {
        var result = false
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            }else{
                result = true
            }
        }
        return result
    }
    
    func isKakaoAcountLoginCallBack(url:URL) -> Bool {
        //kakaoLogin
            if AuthApi.isKakaoTalkLoginUrl(url) {
                return AuthController.handleOpenUrl(url: url)
            }
        return false
    }
    
    func tryKakaoLogin(completion: @escaping (User) -> ()) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (token, error) in
                if let error = error {
                    print(error)
                }else
                {
                    self.appSaveDataModel.saveSnsTypeData(snsType: Int(SNSTYPE.KAKAO.rawValue))
                    UserApi.shared.me { user,error in
                        if let error = error {
                            print(error)
                        }else {
//                            ,let birthday = user.kakaoAccount?.birthday
                            if let user = user {
                                completion(user)
                            }
                        }
                    }
                    // kakao token어떻게 관리할지
//                    UserDefaults.standard.setValue(token, forKey: "LoginToken")
                    
                }
            }
        }
    }
    
    func setUserData(name:String, birthday:String, isSolar:Bool, isBirthdayOpen:Bool,snsType:SNSTYPE, completion: @escaping () -> ()) {
        
        UserApi.shared.me { user,error in
            if let error = error {
                print(error)
                
            }else if let user = user,let userId = user.id, let pushToken = self.appSaveDataModel.useFCMTokenData() {
                
                
//                self.sharedUserData.saveUserData(userData: )
                
                
//                saveUserData(snsId: "\(userId)", snsType: snsType.rawValue, pushToken: pushToken , name: name, birthday: birthday, isSolar: isSolar, isBirthdayOpen: isBirthdayOpen)
                completion()
                
            }
        }
    }
    
    func dissConnectionKakao() {
        UserApi.shared.unlink { error in
            if let error = error {
                print(error)
            }
        }
    }
}
