//
//  AddRoomModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

enum ADDROOMMODEL_RESULT {
    case APPENDITEM
    case UPDATE
    case CHANGE
    case NODATA
    case SELECT
    case DESELECT
    case MAKEROOM
    case RELOADROW
}

class AddRoomModel: NSObject {
    
    let friendsInquiryNetModel:InquiryFriendListNetModel = InquiryFriendListNetModel()
    let makeRoomNetModel:MakeRoomNetModel = MakeRoomNetModel()
    var orgFriendsData:[friendsData]?
    var searchedFriendsData:[friendsData]?
    var selectedFriendsData:[friendsData] = []
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var addRoomModelBlock:((ADDROOMMODEL_RESULT,Any?) -> Void)?
    
    func initWithAddRoomModelBlock(block:@escaping (ADDROOMMODEL_RESULT,Any?) -> Void) {
        addRoomModelBlock = block
    }
    
    func selectFriendAtIndex(index:Int) {
        if let block = self.addRoomModelBlock {
            if var searchedFriendsData = self.searchedFriendsData {
                
                searchedFriendsData[index].isSelected = true
                selectedFriendsData.append(searchedFriendsData[index])
                self.searchedFriendsData = searchedFriendsData
                block(.RELOADROW,(index,searchedFriendsData))
                block(.SELECT,self.selectedFriendsData)
                
                
            }else if var orgFriendsData = self.orgFriendsData {
                
                orgFriendsData[index].isSelected = true
                self.orgFriendsData = orgFriendsData
                selectedFriendsData.append(orgFriendsData[index])
                block(.RELOADROW,(index,orgFriendsData))
                block(.SELECT,self.selectedFriendsData)
                
                
            }
        }
    }
    
    func deSelectUserCollectionViewIndex(index:Int) {
        if let block = self.addRoomModelBlock {
            if var searchedFriendsData = self.searchedFriendsData {
                
                selectedFriendsData.remove(at: selectedFriendsData.firstIndex(where: {$0.friendId == searchedFriendsData[index].friendId})!)
                
                searchedFriendsData[index].isSelected = false
                
                self.searchedFriendsData = searchedFriendsData
                block(.RELOADROW,(index,searchedFriendsData))
                block(.DESELECT,self.selectedFriendsData)
                
            }else if var orgFriendsData = self.orgFriendsData {
                
                selectedFriendsData.remove(at: orgFriendsData.firstIndex(where: {$0.friendId == orgFriendsData[index].friendId})!)
                
                orgFriendsData[index].isSelected = false
                
                self.orgFriendsData = orgFriendsData
                block(.RELOADROW,(index,orgFriendsData))
                block(.DESELECT,self.selectedFriendsData)
                
            }
        }
    }
    
    func deSelectedUserItemIndex(index:Int) {
        if let block = self.addRoomModelBlock {
            if var searchedFriendsData = self.searchedFriendsData {
                let collectionItemIdx = searchedFriendsData.firstIndex(where: {$0.friendId == selectedFriendsData[index].friendId})!
                searchedFriendsData[collectionItemIdx].isSelected = false
                
                self.selectedFriendsData.remove(at: index)
                
                self.searchedFriendsData = searchedFriendsData
                block(.RELOADROW,(collectionItemIdx,searchedFriendsData))
                block(.DESELECT,self.selectedFriendsData)
                
            }else if var orgFriendsData = self.orgFriendsData {
                let collectionItemIdx = orgFriendsData.firstIndex(where: {$0.friendId == selectedFriendsData[index].friendId})!
                orgFriendsData[collectionItemIdx].isSelected = false
                
                self.selectedFriendsData.remove(at: index)
                
                self.orgFriendsData = orgFriendsData
                block(.RELOADROW,(collectionItemIdx,orgFriendsData))
                block(.DESELECT,self.selectedFriendsData)
                
            }
            
        }
        
    }
    
    func searchFriendsData(searchStr:String) {
        if searchStr == "" {
            if let block = self.addRoomModelBlock,let orgData = self.orgFriendsData{
                block(.CHANGE,orgData)
                self.searchedFriendsData?.removeAll()
            }
            return
        }
        if let orgFriendsData = orgFriendsData {
            for friendsData in orgFriendsData {
                if friendsData.name.contains(searchStr) {
                    searchedFriendsData?.append(friendsData)
                }
            }
            if let searchedFriendsData = addRoomModelBlock {
                if let block = self.addRoomModelBlock {
                    block(.CHANGE,searchedFriendsData)
                }
            }else {
                if let block = self.addRoomModelBlock {
                    block(.NODATA,["noitem"])
                }
            }
        }
    }
    
    func tryRequestFriendsList(context:DataContract) {
        
        self.friendsInquiryNetModel.setRequestPathParams(path: [
            "\(sharedUserDataModel.userData.userId)"
        ])
        
        self.friendsInquiryNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[friendsData]>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response {
                    if let block = self.addRoomModelBlock {
                        self.orgFriendsData = response
                        block(.UPDATE,response)
                    }
                }
                break
            default:
                break
            }
            
        }
    }
    
    func tryRequestMakeRoom(context:DataContract) {
        self.makeRoomNetModel.setRequestBodyParams(params: [
            "member":self.selectedFriendsData,
            "name":"\(sharedUserDataModel.userData.name)",
            "opened":true,
            "userId":"\(sharedUserDataModel.userData.userId)"
        ])
        self.makeRoomNetModel.reqeustRestFulApi(context: context) { (data:Result<json<roomData>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response,let block = self.addRoomModelBlock {
                    block(.MAKEROOM,response)
                }
            default:
                break
            }
        }
    }
    
    
    
}
