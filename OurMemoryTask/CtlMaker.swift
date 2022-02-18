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
    case eContractSignup
    case eContractMain
    case eContractFriendList
    case eContractRoomList
    case eContractRoomDetail
    case eContractSchedule
    case eContractSharedList
    case eContractAddSchedule
    case eContractTodoList
    case eContractMyMemory
    case eContractOurMemory
    case eContractMyProFile
    case eContractButkitList
    case eContractNoti
    case eContractSelectAlramTime
    case eContractSelectColor
    case eContractSelectShared
    case eContractSelectDate
    case eContractAddFriend
}

open class CtlMaker: NSObject {

    open func createDataControllerWithContract<T>(contract:ctls,view:T,data:Any?) -> DataContract? {
        var retVal:DataContract!
        switch contract {
        case .eContractIntro:
            if let _ = view as? IntroView {
                retVal = IntroCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractLogin:
            if let _ = view as? LoginView {
                retVal = LoginCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSignup:
            if let _ = view as? SignupView {
                retVal = SignupCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractMain:
            if let _ = view as? MainView {
                retVal = mainCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractFriendList:
            if let _ = view as? FriendView {
                retVal = FriendCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSchedule:
            if let _ = view as? ScheduleView {
                retVal = ScheduleCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractRoomList:
            if let _ = view as? RoomView {
                retVal = roomCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractRoomDetail:
            if let _ = view as? RoomDetailView {
                retVal = RoomDetailCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractAddSchedule:
            if let _ = view as? AddScheduleView {
                retVal = AddScheduleCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractTodoList:
            if let _ = view as? TodoListView {
                retVal = TodoListCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSharedList:
            if let _ = view as? SharedListView {
                retVal = SharedListCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractMyMemory:
            if let _ = view as? MyMemoryView {
                retVal = MyMemoryCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractOurMemory:
            if let _ = view as? OurMemoryView {
                retVal = OurMemoryCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractMyProFile:
            if let _ = view as? MyProfileView {
                retVal = MyProfileCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractButkitList:
            if let _ = view as? ButkitListView {
                retVal = ButkitListCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractNoti:
            if let _ = view as? NotiView {
                retVal = NotiCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSelectAlramTime:
            if let _ = view as? SelectAlarmView {
                retVal = SelectAlarmCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSelectColor:
            if let _ = view as? SelectColorView {
                retVal = SelectColorCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSelectShared:
            if let _ = view as? SelectSharedView {
                retVal = SelectSharedCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractSelectDate:
            if let _ = view as? SelectDateView {
                retVal = SelectDateCtl(view: view as! ViewContract, data: data)
            }
            break
        case .eContractAddFriend:
            if let _ = view as? AddFriendView {
                retVal = AddFriendCtl(view: view as! ViewContract, data: data)
            }
        }
        
        return retVal
        
    }
    
}
