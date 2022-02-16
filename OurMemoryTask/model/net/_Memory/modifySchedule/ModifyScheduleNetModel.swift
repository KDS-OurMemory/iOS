//
//  ModifyScheduleNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/11.
//

import UIKit

class ModifyScheduleNetModel: BaseNetModel {

    override func getPath() -> String {
        return NETPATH.PATH_MEMORIES.path
    }
    
    override func getHttpMethod() -> HTTPMethod {
        return HTTPMethod.put
    }
}
