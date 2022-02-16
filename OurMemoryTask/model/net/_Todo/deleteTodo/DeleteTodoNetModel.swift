//
//  DeleteTodoNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class DeleteTodoNetModel: BaseNetModel {

    override func getPath() -> String {
        return NETPATH.PATH_TODO.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}
