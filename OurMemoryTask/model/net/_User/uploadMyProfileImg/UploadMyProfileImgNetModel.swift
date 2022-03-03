//
//  UploadMyProfileNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class UploadMyProfileImgNetModel: BaseNetModel {

    override func getPath() -> String {
        return NETPATH.PATH_USER.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
}
