//
//  AddFriendsIDModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/22.
//

import UIKit

enum ADDFRIENDSID_RESULT {
    case UPDATEFINDDATA
    case UPDATEGETTINGFRIENDREQUEST
    case NODATA
    case CHANGEFINDDATA
    case CHANGEGETTINGFRIENDREQUEST
    case APPENDDATA
    case ACCEPTFRIEND
}

class AddFriendsIDModel: NSObject {
    let acceptRequestFriendNetModel:AcceptRequestFriendNetModel = AcceptRequestFriendNetModel()
    let addFriendsIdNetModel:SearchForFriendsNetModel = SearchForFriendsNetModel()
    let requestFriendsNetModel:RequestFriendNetModel = RequestFriendNetModel()
    let cancelRequestFriendsNetModel:CancelRequestFriendNetModel = CancelRequestFriendNetModel()
    var addFriendsIdBlock:((ADDFRIENDSID_RESULT,Any?) -> Void)?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var searchResultFriendsList:[friendsData]?
    
    func initWithAddfriendsIdBlock(block:@escaping (ADDFRIENDSID_RESULT,Any?) -> Void) {
        addFriendsIdBlock = block
    }
    
    func tryRequestAddFriendsSearchId(context:DataContract, searchID:String) {
        self.addFriendsIdNetModel.setRequestPathAndQuery(path: [
            "\(sharedUserDataModel.userData.userId)",
            "search"
        ], query: [
            "targetId":searchID,
            
        ])
        self.addFriendsIdNetModel.reqeustRestFulApi(context: context) { (data :Result<json<[friendsData]>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response {
                    if let block = self.addFriendsIdBlock {
                        self.searchResultFriendsList = response
                        if let searchResult = self.searchResultFriendsList {
                            block(.UPDATEGETTINGFRIENDREQUEST ,searchResult.filter({$0.friendStatus == "REQUESTED_BY"}))
                            block(.UPDATEFINDDATA,searchResult.filter({$0.friendStatus != "REQUESTED_BY"}))
                        }
                    }
                }
            default:
                break
            }
        }
        
    }
    
    func tryCancelRequestFriends(context:DataContract,searchIdx:Int) {
        if let searchResult = self.searchResultFriendsList {
            self.cancelRequestFriendsNetModel.setRequestPathParams(path: [
                "\(sharedUserDataModel.userData.userId)",
                "friendUsers",
                "\(searchResult[searchIdx].getFriendID())"
            ])
        }

        self.cancelRequestFriendsNetModel.reqeustRestFulApi(context: context) { (data: Result<json<friendsData>, Error>) in
            switch data {
            case.success(let response):
                if let response = response.response {
                    if let block = self.addFriendsIdBlock,var searchResult = self.searchResultFriendsList {
                        searchResult[searchIdx] = response
                        self.searchResultFriendsList = searchResult
                        
                        block(.CHANGEGETTINGFRIENDREQUEST ,searchResult.filter({$0.friendStatus == "REQUESTED_BY"}))
                        block(.CHANGEFINDDATA,searchResult.filter({$0.friendStatus != "REQUESTED_BY"}))
                    }
                }
            break
            default:
                break
            }
        }
        
    }
    
    func tryAcceptRequestFriends(context:DataContract,acceptIdx:Int) {
        
        if var friendList = self.searchResultFriendsList {
            
            self.acceptRequestFriendNetModel.setRequestBodyParams(params: [
                "friendUserId":friendList[acceptIdx].getFriendID(),
                "userId":"\(sharedUserDataModel.userData.userId)"
            ])
            
            self.acceptRequestFriendNetModel.reqeustRestFulApi(context: context) { (data:Result<json<friendsData>, Error>) in
                switch data {
                case .success(_):
                    if let block = self.addFriendsIdBlock {
                        friendList.remove(at: acceptIdx)
                        block(.ACCEPTFRIEND,friendList)
                        self.searchResultFriendsList = friendList
                    }
                default:
                    break
                }
            }
        }
    }
    
    func tryRequestFriends(context:DataContract,searchIdx:Int) {
        self.requestFriendsNetModel.setRequestBodyParams(params: [
                "friendUserId":self.searchResultFriendsList![searchIdx].getFriendID(),
                "userId":"\(sharedUserDataModel.userData.userId)"
        ])
        self.requestFriendsNetModel.reqeustRestFulApi(context: context) { (data:Result<json<friendsData>, Error>) in
            switch data {
            case.success(let response):
                if let response = response.response {
                    if let block = self.addFriendsIdBlock,var searchResult = self.searchResultFriendsList {
                        searchResult[searchIdx] = response
                        self.searchResultFriendsList = searchResult
                        
                        block(.CHANGEGETTINGFRIENDREQUEST ,searchResult.filter({$0.friendStatus == "REQUESTED_BY"}))
                        block(.CHANGEFINDDATA,searchResult.filter({$0.friendStatus != "REQUESTED_BY"}))
                    }
                }
            break
            default:
                break
            }
        }
    }
}
