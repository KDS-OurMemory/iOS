//
//  AddFriendsNameModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

enum ADDFRIENDSNAME_RESULT {
    case UPDATEFINDDATA
    case UPDATEGETTINGFRIENDREQUEST
    case NODATA
    case CHANGEFINDDATA
    case CHANGEGETTINGFRIENDREQUEST
    case APPENDDATA
    case ACCEPTFRIEND
}

class AddFriendsNameModel: NSObject {

    let acceptRequestFriendNetModel:AcceptRequestFriendNetModel = AcceptRequestFriendNetModel()
    let addFriendsNameNetModel:SearchForFriendsNetModel = SearchForFriendsNetModel()
    let requestFriendsNetModel:RequestFriendNetModel = RequestFriendNetModel()
    let cancelRequestFriendsNetModel:CancelRequestFriendNetModel = CancelRequestFriendNetModel()
    var addFriendsNameBlock:((ADDFRIENDSNAME_RESULT,Any?) -> Void)?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var searchResultFriendsList:[friendsData]?
    
    func initWithblock(block:@escaping (ADDFRIENDSNAME_RESULT,Any?) -> Void) {
        addFriendsNameBlock = block
    }
    
    func tryRequestAddFriendsSearchName(context:DataContract, searchName:String) {
        self.addFriendsNameNetModel.setRequestPathAndQuery(path: [
            "\(sharedUserDataModel.userData.userId)",
            "search"
        ], query: [
            "name":searchName,
            
        ])
        self.addFriendsNameNetModel.reqeustRestFulApi(context: context) { (data :Result<json<[friendsData]>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response {
                    if let block = self.addFriendsNameBlock {
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
                    if let block = self.addFriendsNameBlock,var searchResult = self.searchResultFriendsList {
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
                    if let block = self.addFriendsNameBlock {
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
                    if let block = self.addFriendsNameBlock,var searchResult = self.searchResultFriendsList {
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
