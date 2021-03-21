//
//  IntroNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation

class IntroNetModel:BaseNetModel {
    
    var data:introModel!
    var path:String = "/v1/user/"
    
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
    
    func tryRequestRestfulAPI(completion: @escaping (Bool) -> Void ) {
        if let snsId = UserDefaults.standard.string(forKey: "userSnsID"){
            let param:RequestParam = .url(["snsId":snsId])
            
            self.reqeustRestFulApi(method: HTTPMethod.get, path: self.path, params: param) { (result: Result< introModel, Error>) in
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
