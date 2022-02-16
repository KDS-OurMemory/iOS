//
//  IntroNetModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import Foundation

enum INTRONETCASE {
    case KNOWN_CASE
    case NOTCONNECTNET_CASE
    case REQUESTERROR_CASE
    case SUCCESS_CASE
    case FAILE_CASE
}


class IntroNetModel:BaseNetModel {
    
//    var userDataCallback:((INTRONETCASE)-> Void)!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    
//    func initWithCallback(callback: @escaping (INTRONETCASE) -> Void ) {
//        self.userDataCallback = callback
//    }
    
}
