//
//  NetDataVO.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import Foundation

struct json<T: Codable>: Codable{
    
    let detailMessage: String?
    let response:T?
    let responseDate: String
    let resultCode: String
    let resultMessage: String
    
    enum CodingKeys: String, CodingKey {
        case detailMessage = "detailMessage"
        case response = "response"
        case responseDate = "responseDate"
        case resultCode = "resultCode"
        case resultMessage = "resultMessage"
    }
    
}

public struct userData:Codable {
    let birthday: String
    let birthdayOpen: Bool
    let deviceOs: String
    let name: String
    let privateRoomId: Int64
    let profileImageUrl: String?
    let push: Bool
    let pushToken: String
    let role : String
    let snsId: String
    let snsType: Int32
    let solar: Bool
    let userId: Int64
    
    enum CodingKeys: String, CodingKey {
        case birthday = "birthday"
        case birthdayOpen = "birthdayOpen"
        case deviceOs = "deviceOs"
        case name = "name"
        case privateRoomId = "privateRoomId"
        case profileImageUrl = "profileImageUrl"
        case push = "push"
        case pushToken = "pushToken"
        case role = "role"
        case snsId = "snsId"
        case snsType = "snsType"
        case solar = "solar"
        case userId = "userId"
    }
    
    
    func getName() -> String? {
        return name
    }
    
    func getBirthday() -> String? {
        return birthday
    }
    
    func getBirthdayOpen() -> Bool? {
        return birthdayOpen
    }
    
    func getIsSolar() -> Bool? {
        return solar
    }
}

struct scheduleData:Codable {
    let addedRoomId:Int64?
    let bgColor:String // #FFFFFF
    let contents:String
    let endDate:String
    let firstAlarm:String
    let memoryId:Int64
    let modDate:String
    let name:String
    let place:String
    let regDate:String
    let secondAlarm:String
    let shareRooms:[roomData]?
    let startDate:String //yyyy-MM-dd HH:mm
    let userAttendances:String
    let writerId:Int64
    
}

struct roomData:Codable {
    let name:String
    let ownerId:Int64
    let roomId:Int
}
