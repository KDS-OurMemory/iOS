//
//  RequestFriendNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class RequestFriendNetModel: BaseNetModel {
    
    override func getRequestParamsKeys() -> [String : Any?]? {
        return [
            "friendStatus":nil,
            "friendUserId":nil,
            "userId":nil,
        ]
    }
    
    override func getPath() -> String {
        return NETPATH.PATH_FRIENDS.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
}
