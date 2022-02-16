//
//  ModifyPushTokenNetmodel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class ModifyPushTokenNetmodel: BaseNetModel {

    override func getRequestParamsKeys() -> [String : Any?]? {
        return [
            "birthday":nil,
            "birthdayOpen":nil,
            "deviceOs":nil,
            "name":nil,
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
        return HTTPMethod.patch
    }
    
}
