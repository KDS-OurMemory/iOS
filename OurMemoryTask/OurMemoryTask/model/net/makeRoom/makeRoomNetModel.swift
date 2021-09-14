//
//  makeRoomNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/06.
//

class makeRoomNetModel: BaseNetModel {
    
    var data:makeRoomResponseData!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    var name:String?
    var member:[Int] = []
    var opened:Bool?
    
    func tryMakeRoomRequest() {
        if let name = name,
           let owner = sharedUserDataModel.userId,
           let opened = opened {
            let param:RequestParam = .body([
                "snsId":name,
                "owner":"\(owner)",
                "member":"\(member)",
                "opened":"\(opened)"
            ])
            
            self.reqeustRestFulApi(method: HTTPMethod.post, path: NETPATH.PATH_ROOMS.rawValue, params: param) { (result: Result< makeRoomResponseData, Error>) in
                switch result
                {
                case .success(let data) :
                    self.data = data
                    break
                case .failure(let error) :
                    print("Intro network Request Error ======>" + error.localizedDescription)
                    break
                }
            }
        }
    }
}
