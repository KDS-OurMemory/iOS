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

open class CtlMaker: NSObject {

    open func createDataControllerWithContract<T>(contract:ctls,view:T) -> DataContract? {
        var retVal:DataContract!
        switch contract {
        case .eContractIntro:
            if let _ = view as? IntroView {
                retVal = IntroCtl(view: view as! ViewContract)
            }
            break
        case .eContractLogin:
            if let _ = view as? LoginView {
                retVal = LoginCtl(view: view as! ViewContract)
            }
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
