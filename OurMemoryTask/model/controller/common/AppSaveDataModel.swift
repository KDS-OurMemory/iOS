//
//  AppSaveDataModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//

class AppSaveDataModel: NSObject {

    let userDefault = UserDefaults.standard
    
    func saveSnsTypeData(snsType:Int) {
        userDefault.setValue(snsType, forKey: "userSnsType")
    }
    
    func useSnsTypeData() -> Int? {
        return userDefault.value(forKey: "userSnsType") != nil ? userDefault.integer(forKey: "userSnsType"):nil
    }
    
    func saveSnsIDData(userSnsID:String) {
        userDefault.setValue(userSnsID, forKey: "userSnsID")
    }
    
    func useSnsIDData() -> Int? {
        return userDefault.value(forKey: "userSnsID") != nil ? userDefault.integer(forKey: "userSnsID"):nil
    }
    
    func saveUserIDData(userID:String) {
        userDefault.setValue(userID, forKey: "userID")
    }
    
    func useUserIDData() -> Int? {
        return userDefault.value(forKey: "userID") != nil ? userDefault.integer(forKey: "userID"):nil
    }
    
    func saveFCMTokenData(fcmToken:String) {
        userDefault.setValue(fcmToken, forKey: "fcmToken")
    }
    
    func useFCMTokenData() -> String? {
        return userDefault.string(forKey: "fcmToken")
    }
    
    func usePushTokenAllow() -> Bool {
        return userDefault.bool(forKey: "push")
    }
    
    func clearData() {
        userDefault.removeObject(forKey: "userID")
        userDefault.removeObject(forKey: "userSnsType")
        userDefault.removeObject(forKey: "userSnsID")
        userDefault.removeObject(forKey: "fcmToken")
        userDefault.removeObject(forKey: "push")
    }
}
