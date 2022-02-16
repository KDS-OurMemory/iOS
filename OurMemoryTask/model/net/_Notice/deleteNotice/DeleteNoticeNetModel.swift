//
//  DeleteNoticeNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class DeleteNoticeNetModel: BaseNetModel {

    override func getPath() -> String {
        return NETPATH.PATH_NOTICE.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}
