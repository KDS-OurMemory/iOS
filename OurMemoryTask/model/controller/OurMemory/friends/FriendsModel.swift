//
//  FriendsModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/20.
//

import UIKit

enum FRIENDSMODEL_RESULT {
    case FRIENDSLIST_APPENDITEM
    case FRIENDSLIST_UPDATE
    case FRIENDSLIST_CHANGE
    case FRIENDSLIST_NODATA
}

class FriendsModel: NSObject {

    var friendsModelCallback:((FRIENDSMODEL_RESULT,Any?) -> Void)?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let friendsInquiryNetModel:InquiryFriendListNetModel = InquiryFriendListNetModel()
    var orgFriendsData:[friendsData]?
    var searchedFriendsData:[friendsData]?
    
    func initWithCallback(data:Any?, callback:@escaping (FRIENDSMODEL_RESULT,Any?) -> Void) {
        friendsModelCallback = callback
        friendsInquiryNetModel.setRequestPathParams(path: [
            "\(sharedUserDataModel.userData.userId)"
        ])
        
    }
    
    func searchFriendsData(searchStr:String) {
        if searchStr == "" {
            if let callback = self.friendsModelCallback,let orgData = self.orgFriendsData{
                callback(.FRIENDSLIST_CHANGE,orgData)
            }
            return
        }
        if let orgFriendsData = orgFriendsData {
            for friendsData in orgFriendsData {
                if friendsData.name.contains(searchStr) {
                    searchedFriendsData?.append(friendsData)
                }
            }
            if let searchedFriendsData = self.searchedFriendsData {
                if let callback = self.friendsModelCallback {
                    callback(.FRIENDSLIST_CHANGE,searchedFriendsData)
                }
            }else {
                if let callback = self.friendsModelCallback {
                    callback(.FRIENDSLIST_NODATA,["noitem"])
                }
            }
        }
    }
    
    func tryRequestFriendsList(context:DataContract) {
        friendsInquiryNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[friendsData]>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response {
                    if let callback = self.friendsModelCallback {
                        self.orgFriendsData = response
                        callback(FRIENDSMODEL_RESULT.FRIENDSLIST_UPDATE,response)
                    }
                }
                break
            default:
                break
            }
            
        }
    }
    
}
