//
//  SharedUserDataModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//


public class SharedUserDataModel: NSObject {
    
    static let sharedUserData = SharedUserDataModel()
    
    let appSaveDataModel:AppSaveDataModel = AppSaveDataModel()

    var birthDay: String?
    var birthdayOpen: Bool?
    var deviceOs: String?
    var name: String?
    var privateRoomId: Int64?
    var profileImageUrl: String?
    var push: Bool?
    var pushToken: String?
    var role: String?
    var snsId: String?
    var snsType: Int32?
    var solar: Bool?
    var userId: Int64?
    
    
    
    func saveUserData(userData:userData) {
        self.birthDay = userData.birthday
        self.birthdayOpen = userData.birthdayOpen
        self.deviceOs = userData.deviceOs
        self.name = userData.name
        self.privateRoomId = userData.privateRoomId
        self.profileImageUrl = userData.profileImageUrl
        self.push = userData.push
        self.pushToken = userData.pushToken
        self.role = userData.role
        self.snsId = "\(userData.snsId)"
        self.snsType = userData.snsType
        self.solar = userData.solar
        self.userId = userData.userId
        
        self.appSaveDataModel.saveSnsIDData(userSnsID: "\(userData.snsId)")
        self.appSaveDataModel.saveUserIDData(userID: "\(userData.userId)")
        self.appSaveDataModel.saveFCMTokenData(fcmToken: userData.pushToken)
    }
    
//    public func saveUserData(user:userData?) {
//        if let user = user
//        {
//            self.userId = user.userId
//            self.snsType = appSaveDataModel.useSnsTypeData()
//            self.pushToken = appSaveDataModel.useFCMTokenData()
//            self.name = user.name
//            self.birthDay = user.birthday
//            self.isSolar = user.solar
//            self.isBirthdayOpen = user.birthdayOpen
//        }
//
//    }
//
//
//
    func clearData() {
        self.birthDay = nil
        self.birthdayOpen = nil
        self.deviceOs = nil
        self.name = nil
        self.privateRoomId = nil
        self.profileImageUrl = nil
        self.push = nil
        self.pushToken = nil
        self.role = nil
        self.snsId = nil
        self.snsType = nil
        self.solar = nil
        self.userId = nil
        
    }
//
//    func setName(name:String) {
//        self.name = name
//    }
//
//    public func getName() -> String? {
//        return self.name == nil ? nil : self.name
//    }
//
//    public func setBirthday(birthday:String) {
//        self.birthDay = birthday
//    }
//
//    public func getBirthday() -> String? {
//        return self.birthDay == nil ? nil:self.birthDay
//    }
}
