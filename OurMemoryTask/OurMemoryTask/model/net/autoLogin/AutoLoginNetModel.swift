//
//  autoLoginNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/03.
//

import Foundation

class AutoLoginNetModel:BaseNetModel {

    var data:autoLoginResponseData!
    var userDataCallback:((LOGINNETCASE)-> Void)!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    func initWithCallback(callback: @escaping (LOGINNETCASE) -> Void ) {
        self.userDataCallback = callback
    }
    
    func tryAutoLoginRequest() {
        if let snsId = saveDataModel.useSnsIDData() ,let snsType = saveDataModel.useSnsTypeData() {
            let param:RequestParam = .url(["snsId":snsId,"snsType":"\(snsType)"])
            
            self.reqeustRestFulApi(method: HTTPMethod.get, path: NETPATH.PATH_USER.rawValue, params: param) { (result: Result< autoLoginResponseData, Error>) in
                switch result
                {
                case .success(let data) :
                    self.data = data
                    if let response = data.response {
                        self.sharedUserDataModel.saveUserData(user: response)
                    }
                    
                    self.userDataCallback(LOGINNETCASE.SUCCESS_CASE)
                    break
                case .failure(let error) :
                    print("Intro network Request Error ======>" + error.localizedDescription)
                    self.userDataCallback(LOGINNETCASE.REQUESTERROR_CASE)
                    break
                }
            }
        }else {
            self.userDataCallback(LOGINNETCASE.FAILE_CASE)
        }
    }
    
    func getResultCode() -> String {
        return self.data.resultcode
    }
}
