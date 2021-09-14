//
//  dataVO.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/04.
//

import Foundation



enum NETPATH :String{
    case PATH_USER = "/v1/users"
    case PATH_ROOM = "/v1/room"
    case PATH_ROOMS = "/v1/rooms"
}

// AutoLogin

struct autoLoginResponseData: Codable {
    let resultcode: String
    let message: String
    let response: userData?
}

public struct userData: Codable {
    let userId: Int
    let name: String
    let birthday: String?
    let solar: Bool
    let birthdayOpen :Bool
    let pushToken: String
    let push: Bool
}

// Login

struct loginResponseData : Codable {
    let resultcode: String
    let message: String
    let response:joinUserData?
}

struct joinUserData: Codable {
    let userId: Int
    let joinDate: String
}

// makeRoom

struct makeRoomResponseData : Codable {
    let resultcode: String
    let message: String
    let response:makeRoomData?
}

struct makeRoomData : Codable {
    let roomId: Int
    let createDate: String
}

// my rooms

struct myRoomsResponseData: Codable {
    let resultcode: String
    let message: String
    let response: myRoom?
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
