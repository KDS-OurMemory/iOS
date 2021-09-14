//
//  MainModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/23.
//

import Foundation

enum MAINCASE {
    case UPDATE_ROOMLIST
    case UPDATE_DATE
}

class MainModel:NSObject {
    
    var callback:((MAINCASE)-> Void)!
    
    func initWithCallback(callback: @escaping (MAINCASE)-> Void ) {
        self.callback = callback
    }
    
    let getMyRoomListNetModel = getMyRoomNetModel()
    
    func tryGetMyRommList() {
        self.getMyRoomListNetModel.tryMakeRoomRequest(success: {
            switch self.getMyRoomListNetModel.getResultCode() {
            case NETRESULTCODE.ROOMDATAREQUEST_ERROR:
                break
            case NETRESULTCODE.ROOMREQUESTFAILE_ERROR:
                break
            case NETRESULTCODE.SUCCESS:
                self.callback(.UPDATE_ROOMLIST)
                break
            default:
                break
            }
        })
    }
 
    func getMyRoomListData() -> myRoom? {
        return self.getMyRoomListNetModel.getmyRoomList()
    }
}
