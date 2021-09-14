//
//  getMyRoomNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/09.
//

import UIKit

class getMyRoomNetModel: BaseNetModel {

    var data:myRoomsResponseData!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    func tryMakeRoomRequest(success: @escaping () -> Void ) {
        if let userId = sharedUserDataModel.userId{
            let param:RequestParam = .url([
                "userId":"\(userId)",
            ])
            
            self.reqeustRestFulApi(method: HTTPMethod.post, path: NETPATH.PATH_ROOMS.rawValue, params: param) { (result: Result< myRoomsResponseData, Error>) in
                switch result
                {
                case .success(let data) :
                    self.data = data
                    success()
                    break
                case .failure(let error) :
                    print("Intro network Request Error ======>" + error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func getmyRoomList() -> myRoom? {
        if let roomList = self.data.response {
            return roomList
        }
        return nil
    }
    
    func getResultCode() -> String {
        return self.data.resultcode
    }
    
}
