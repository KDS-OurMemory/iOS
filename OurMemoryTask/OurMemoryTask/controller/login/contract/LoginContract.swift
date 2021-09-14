//
//  LoginContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import Foundation

public protocol LoginContract:DataContract {
    /**
     * autoLogin 체크 ( 디바이스에 snsId가 있다면 request 요청 하여 Login 시도)
     */
    func tryAutoLoginRequestLogin(type:SNSTYPE)
    
    /**
     * Login request 시도
     */
    func tryLoginRequest()
}
