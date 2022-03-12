//
//  NetDataVO.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import Foundation
import UIKit

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
// MARK: signUp,Login response userData
struct userData:Codable,UserDataBinder {
    let birthday: String
    var birthdayOpen: Bool
    let deviceOs: String
    let name: String
    let privateRoomId: Int64
    let profileImageUrl: String?
    var push: Bool
    let pushToken: String
    let role : String
    let snsId: String
    let snsType: Int32
    var solar: Bool
    let userId: Int64
    var profileImage:UIImage?
    
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
    
    func getProfileImage(block: @escaping (UIImage?) -> Void) {
        if let url = self.profileImageUrl {
            url.urlStringToImage { p1 in
                block(p1)
            }
        }
    }
    
    func getIsPush() ->Bool {
        return self.push
    }
    
    func getUserId() -> String {
        return "\(self.userId)"
    }
    
    func getName() -> String {
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
    
    func getProfileImage() -> UIImage? {
        return self.profileImage
    }
    
    func getSnsType() -> String {
        
        var snsType = ""
        switch self.snsType {
        case SNSTYPE.KAKAO.rawValue:
            snsType = "카카오"
            break
        case SNSTYPE.GOOGLE.rawValue:
            snsType = "구글"
            break
        case SNSTYPE.NAVER.rawValue:
            snsType = "네이버"
            break
        default:
            break
        }
        return snsType
    }
}
// MARK: addSchedule response scheduleData,roomData
struct scheduleData:Codable,ScheduleDateDataBinder {
    let addedRoomId:Int64?
    let bgColor:String? // #FFFFFF
    let contents:String?
    let endDate:String //yyyy-MM-dd HH:mm
    let firstAlarm:String?
    let memoryId:Int64
    let modDate:String?
    let name:String
    let place:String?
    let regDate:String
    let secondAlarm:String?
    let shareRooms:[shareRoomsData]?
    let startDate:String //yyyy-MM-dd HH:mm
    let userAttendances:String?
    let writerId:Int64
    
    enum CodingKeys: String, CodingKey {
        case addedRoomId = "addedRoomId"
        case bgColor = "bgColor"
        case contents = "contents"
        case endDate = "endDate"
        case firstAlarm = "firstAlarm"
        case memoryId = "memoryId"
        case modDate = "modDate"
        case name = "name"
        case place = "place"
        case regDate = "regDate"
        case secondAlarm = "secondAlarm"
        case shareRooms = "shareRooms"
        case startDate = "startDate"
        case userAttendances = "userAttendances"
        case writerId = "writerId"
    }
    
    func getScheduleColor() -> UIColor? {
        return self.bgColor?.rgbToUIColor()
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getDateSchedule() ->String {
        var result = ""
        result += self.startDate
        result += " ~ "
        result += self.endDate
        
        return result
    }
    
}

struct shareRoomsData:Codable {
    let name:String
    let ownerId:Int64
    let roomId:Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case ownerId = "ownerId"
        case roomId = "roomId"
    }
}

// MARK: response friendsData
struct friendsData:Codable,FriendsDataBinder {
    
    let birthday:String
    let birthdayOpen:Bool
    let friendId:Int64
    let friendStatus:String?
    let name:String
    let profileImageUrl:String?
    let solar:Bool
    var isSelected:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case birthday = "birthday"
        case birthdayOpen = "birthdayOpen"
        case friendId = "friendId"
        case friendStatus = "friendStatus"
        case name = "name"
        case profileImageUrl = "profileImageUrl"
        case solar = "solar"
    }
    
    func getBirthday() -> String {
        return self.birthday
    }
    
    func getBirthdayOpen() -> Bool {
        return self.birthdayOpen
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getProfileImageUrl() -> String? {
        return self.profileImageUrl
    }
    
    func getSolar() -> Bool {
        return self.solar
    }
    
    func getFriendStatus() -> FRIENDS_STATUS? {
        return FRIENDS_STATUS.init(rawValue: self.friendStatus ?? "")
    }
    
    func getFriendID() -> String {
        return "\(self.friendId)"
    }
    
    func getProfileImage(block:@escaping (UIImage?) -> Void) {
        if let url = self.profileImageUrl {
            url.urlStringToImage { p1 in
                block(p1)
            }
        }
    }
    
    func getIsSelected() -> Bool? {
        return self.isSelected
    }
    
}

struct roomData:Codable,RoomDataBinder {
    let members:[friendsData]
    let memories:[scheduleData]
    let name:String
    let opened:Bool
    let ownerId:Int64
    let regDate:String
    let roomId:Int64
    
    enum CodingKeys: String, CodingKey {
        case members = "members"
        case memories = "memories"
        case name = "name"
        case opened = "opened"
        case ownerId = "ownerId"
        case regDate = "regDate"
        case roomId = "roomId"
    }
    
    func getUserCnt() -> Int {
        return members.count
    }
    
    func getName() -> String {
        return self.name
    }
}

