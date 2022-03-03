//
//  RoomsModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

enum ROOMSMODEL_RESULT {
    case ROOMSLIST_APPENDITEM
    case ROOMSLIST_UPDATE
    case ROOMSLIST_CHANGE
    case ROOMSSLIST_NODATA
}

class RoomsModel: NSObject {

    var roomsModelCallback:((ROOMSMODEL_RESULT,Any?) -> Void)?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let roomsInquiryNetModel:InquiryRoomListNetModel = InquiryRoomListNetModel()
    var orgRoomsData:[roomData]?
    var searchRoomsData:[roomData]?
    
    func initWithCallback(data:Any?, callback:@escaping (ROOMSMODEL_RESULT,Any?) -> Void) {
        roomsModelCallback = callback
        roomsInquiryNetModel.setRequestQueryParams(params: [
            "userId":"\(sharedUserDataModel.userData.userId)"
        ])
        
    }
    
    func searchFriendsData(searchStr:String) {
        if searchStr == "" {
            if let callback = self.roomsModelCallback,let orgData = self.orgRoomsData {
                searchRoomsData = nil
                callback(.ROOMSLIST_CHANGE,orgData)
            }
            return
        }
        if self.orgRoomsData != nil {
//            for roomsData in orgRoomsData {
//
//            }
            if let searchRoomsData = searchRoomsData {
                if let callback = self.roomsModelCallback {
                    callback(.ROOMSLIST_CHANGE,searchRoomsData)
                }
            }else {
                if let callback = self.roomsModelCallback {
                    callback(.ROOMSLIST_CHANGE,["noitem"])
                }
            }
        }
    }
    
    func getSelectDataIdx(index:Int) -> RoomDataBinder {
        
        if self.searchRoomsData != nil {
            return self.searchRoomsData![index]
        } else {
            return self.orgRoomsData![index]
        }
    }
    
    func tryRequestRoomsList(context:DataContract) {
        self.roomsInquiryNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[roomData]>, Error>) in
            switch data {
            case .success(let response):
                if let callback = self.roomsModelCallback {
                    self.orgRoomsData = response.response
                    callback(ROOMSMODEL_RESULT.ROOMSLIST_UPDATE,self.orgRoomsData)
                }
                break
            default:
                break
            }
        }
    }
    
}
