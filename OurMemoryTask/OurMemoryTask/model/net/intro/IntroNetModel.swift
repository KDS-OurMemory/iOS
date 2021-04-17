//
//  IntroNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation

enum NETPATH :String{
    case PATH_USER = "/v1/user/"
}

class IntroNetModel:BaseNetModel {
    
    var data:introModel!
    
    override init() {
        super.init()
    }
    
    struct introModel: Codable {
        let resultCode: String
        let data: [data]
    }
    
    struct data: Codable {
        let id: Float
        let name: String
        let birthday: String?
        let isSolar: Bool
        let isBirthdayOpen :Bool
    }
    
    func tryRequestLoginIntro (completion: @escaping (Bool) -> Void ) {
        if let snsId = UserDefaults.standard.string(forKey: "userSnsID") ,let snsType = UserDefaults.standard.string(forKey: "userSnsType") {
            let param:RequestParam = .url(["snsId":snsId,"snsType":snsType])
            
            self.reqeustRestFulApi(method: HTTPMethod.get, path: NETPATH.PATH_USER.rawValue, params: param) { (result: Result< introModel, Error>) in
                switch result
                {
                case .success(let data) :
                    self.data = data
                    completion(true)
                    break
                case .failure(let error) :
                    print("Intro network Request Error ======>" + error.localizedDescription)
                    completion(false)
                    break
                }
            }
        }else {
            completion(false)
        }
    }
    
    func tryRequestPushTokenReflash (completion: @escaping (Bool) -> Void ) {
        if let userId = UserDefaults.standard.string(forKey: "userID"), let pustToken = UserDefaults.standard.string(forKey: "userID"){
            var param:RequestParam = .url(["userId":userId])
            param = .body(["pushToken": pustToken])
            self.reqeustRestFulApi(method: HTTPMethod.get, path: NETPATH.PATH_USER.rawValue, params: param) { (result: Result< introModel, Error>) in
                switch result
                {
                case .success(let data) :
                    self.data = data
                    
                    completion(true)
                    break
                case .failure(let error) :
                    print("Intro network Request Error ======>" + error.localizedDescription)
                    completion(false)
                    break
                }
            }
        }
    }
    
}
