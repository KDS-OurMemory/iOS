//
//  LoginNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

import UIKit

class LoginNetModel: BaseNetModel {

    var userDataCallback:((LOGINNETCASE)-> Void)!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    override func getPath() -> String {
        self.path = NETPATH.PATH_USER
        return path.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
    
    override func getRequestParamsKeys() -> [String : Any?]? {
        return [
            "snsId":nil,
            "snsType":nil,
        ]
    }
    
    func initWithCallback(callback: @escaping (LOGINNETCASE) -> Void ) {
        self.userDataCallback = callback
    }
    
//    func tryLoginRequest() {
//        if let snsId = saveDataModel.useSnsIDData(),
//           let snsType = saveDataModel.useSnsTypeData(),
//           let pushToken = saveDataModel.useFCMTokenData(),
//           let name = sharedUserDataModel.name,
//           let birthday = sharedUserDataModel.birthDay
//           {
//            let param:RequestParam = .body([
//                "snsId":snsId,
//                "snsType":snsType,
//                "pushToken":pushToken,
//                "name":name,
//                "birthday":birthday,
//                "isSolar":sharedUserDataModel.isSolar,
//                "isBirthdayOpen":sharedUserDataModel.isBirthdayOpen,
//                "deviceOs":sharedUserDataModel.deviceOs
//            ])
//            self.reqeustRestFulApi(method: HTTPMethod.post, path: NETPATH.PATH_USER.rawValue, params: param) { (result: Result< json<loginResponseData>, Error>) in
//                switch result
//                {
//                case .success(let data) :
//                    let response = data.response
//                    self.userDataCallback(LOGINNETCASE.SUCCESS_CASE)
//                    break
//                case .failure(let error) :
//                    print("Login network Request Error ======>" + error.localizedDescription)
//                    self.userDataCallback(LOGINNETCASE.REQUESTERROR_CASE)
//                    break
//                }
//            }
//        }else {
//            self.userDataCallback(LOGINNETCASE.FAILE_CASE)
//        }
//    }
}
