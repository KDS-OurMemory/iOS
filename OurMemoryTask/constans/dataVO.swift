//
//  dataVO.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/04.
//

import Foundation

struct ImageFile {
    let fileName: String
    let data: Data
    let type: String
    let key: String
}

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

// AutoLogin

//struct autoLoginResponseData : Codable {
//    let resultcode: String
//    let message: String
//    let response: userData?
//}
public struct signup_userData: Codable {
    let signupUserData:userData
    enum CodingKeys: String, CodingKey {
        case signupUserData = "response"
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

// Login

struct loginResponseData : Codable {
    let loginResponseData:joinUserData
    enum CodingKeys: String, CodingKey {
        case loginResponseData = "response"
    }
}

struct joinUserData: Codable {
    let userId: Int
    let joinDate: String
}

// makeRoom

struct makeRoomResponseDatgga : Codable {
    let makeRoomResponseData:makeRoomData?
    enum CodingKeys: String, CodingKey {
        case makeRoomResponseData = "response"
    }
}

struct makeRoomData : Codable {
    let roomId: Int
    let createDate: String
}

struct myRoom: Codable {
    let roomId: Int
    let owner: Int
    let name: String
    let regDate: String
    let opened: Bool
    let members: myRoomMembersData
    let memories: contentsData
}

struct myRoomMembersData: Codable {
    let userId: Int
    let name: String
    let birthday: String?
    let solar: Bool
    let birthdayOpen: Bool
}

struct contentsData: Codable {
    let name:String
    let startDate:String
    let endDate:String
}

struct SIGNUP_CHACK:OptionSet {
    
    let rawValue: Int
    
    static let SIGNUP_UNKNOWN = 1
    static let SIGNUP_BIRTHDAY = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 1)
    static let SIGNUP_DEVICEOS = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 2)
    static let SIGNUP_NAME = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 3)
    static let SIGNUP_SNSID = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 4)
    static let SIGNUP_SNSTYPE = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 5)
    static let SIGNUP_SOLAR = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 6)
    static let SIGNUP_BIRTHDAYOPEN = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 7)
    static let SIGNUP_ROLE = SIGNUP_CHACK(rawValue: SIGNUP_UNKNOWN << 8)
    
}

struct signUpInputUserData:SignupUserDataBinder {
    let name:String?
    let birthday:String?
    let birthdayOpen:Bool?
    let solar:Bool?
    let snsId:String
    let snsType:SNSTYPE
    
    init(name:String?, birthday:String?, birthdayOpen:Bool?, solar:Bool?, snsId:String, snsType:SNSTYPE) {
        self.name = name
        self.birthday = birthday
        self.birthdayOpen = birthdayOpen
        self.solar = solar
        self.snsId = snsId
        self.snsType = snsType
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func getBirthday() -> String? {
        return self.birthday
    }
    
    func getBirthdayOpen() -> Bool? {
        return self.birthdayOpen
    }
    
    func getSolar() -> Bool? {
        return self.solar
    }
    
    func getSnsId() -> String {
        return self.snsId
    }
    
    func getSnsType() -> SNSTYPE {
        return self.snsType
    }
}
