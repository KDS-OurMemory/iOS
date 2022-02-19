//
//  SelectShareListModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import UIKit

enum SELECTSHARELIST_RESULT {
   case SELECTSHARELIST_UPDATELIST_RESULT
}

class SelectShareListModel: NSObject {

    let sharedUserDataModal:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let selectShareListNetModel:InquiryFriendListNetModel = InquiryFriendListNetModel()
    var selectShareListCallback:((SELECTSHARELIST_RESULT,Any?) -> Void)?
    
    func initWithCallback(data: Any?, callBack: @escaping (SELECTSHARELIST_RESULT,Any?) -> Void) {
        selectShareListCallback = callBack
    }
    
    func tryRequestShareList(context:DataContract) {
        
        self.selectShareListNetModel.addPath(path: "\(sharedUserDataModal.userId!)")
        self.selectShareListNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[freindsData]>, Error>) in
            switch data {
            case .success(let response):
                if let response = response.response,let callBack = self.selectShareListCallback {
                    callBack(.SELECTSHARELIST_UPDATELIST_RESULT,response)
                }
                break
            default:
                break
            }
        }
    }
}
