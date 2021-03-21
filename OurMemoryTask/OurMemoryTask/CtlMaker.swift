//
//  CtlMaker.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/21.
//

import UIKit

public enum ctls {
    case eContractIntro
    case eContractLogin
    case eContractMain
    case eContractFriendList
    case eContractRoomList
    case eContractRoomDetail
    case eContractSchedule
}

public class CtlMaker: NSObject {

    public func createDataControllerWithContract<T>(contract:ctls,view:T) -> Any? {
        var retVal:Any!
        switch contract {
        case .eContractIntro:
            if T.self is IntroView.Type {
                retVal = IntroCtl()
            }
            break
        case .eContractLogin:
            break
        case .eContractMain:
            break
        case .eContractFriendList:
            break
        case .eContractSchedule:
            break
        case .eContractRoomList:
            break
        case .eContractRoomDetail:
            break
        }
        
        return retVal
        
    }
    
}
