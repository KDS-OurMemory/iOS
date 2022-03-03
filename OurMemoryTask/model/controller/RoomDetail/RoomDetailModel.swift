//
//  RoomDetailModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/26.
//

import UIKit

enum ROOMDETAIL_RESULT {
    case UPDATEDATA
}

class RoomDetailModel: NSObject {

    var roomDetailBlock:((ROOMDETAIL_RESULT,Any?) -> Void)?
    var roomData:roomData!
    
    func initRoomDetailDataWithBlock(data:Any?, block:@escaping (ROOMDETAIL_RESULT,Any?) -> Void) {
        roomDetailBlock = block
        roomData = data as? roomData
    }
    
}
