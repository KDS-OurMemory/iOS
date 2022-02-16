//
//  LoginContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import Foundation
import KakaoSDKUser

public protocol LoginContract:DataContract {
    
    func startKakaoLoginProccess()
    
    func startGoogleLoginProccess()
    
    func startNaverLoginProccess()
    
    func openUrlForSnsLogin(url:URL) -> Bool
}
