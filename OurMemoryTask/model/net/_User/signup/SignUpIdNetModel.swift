//
//  autoLoginNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/03.
//

import Foundation

class SignUpIdNetModel:BaseNetModel {
    
    override func getRequestParamsKeys() -> [String : Any?]? {
        return [
            "birthday":nil,
            "birthdayOpen":nil,
            "deviceOs":nil,
            "name":nil,
            "profileImage":nil,
            "push":nil,
            "pushToken":nil,
            "snsId":nil,
            "snsType":nil,
            "solar":nil,
        ]
    }
    
    override func getPath() -> String {
        return NETPATH.PATH_USER.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    
}
