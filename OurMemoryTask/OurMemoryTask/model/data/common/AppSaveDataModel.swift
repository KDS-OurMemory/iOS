//
//  AppSaveDataModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//


public class AppSaveDataModel: NSObject {

    let userDefault = UserDefaults.standard
    
    public func saveSnsTypeData(snsType:Int) {
        userDefault.setValue(snsType, forKey: "userSnsType")
    }
    
    public func useSnsTypeData() -> Int? {
        return userDefault.value(forKey: "userSnsType") != nil ? userDefault.integer(forKey: "userSnsType"):nil
    }
    
    public func saveSnsIDData(userSnsID:String) {
        userDefault.setValue(userSnsID, forKey: "userSnsID")
    }
    
    public func useSnsIDData() -> String? {
        return userDefault.value(forKey: "userSnsID") != nil ? userDefault.string(forKey: "userSnsID"):nil
    }
    
    public func saveUserIDData(userID:String) {
        userDefault.setValue(userID, forKey: "userID")
    }
    
    public func useUserIDData() -> String? {
        return userDefault.value(forKey: "userID") != nil ? userDefault.string(forKey: "userID"):nil
    }
    
    public func saveFCMTokenData(fcmToken:String) {
        userDefault.setValue(fcmToken, forKey: "fcmToken")
    }
    
    public func useFCMTokenData() -> String? {
        return userDefault.value(forKey: "fcmToken") != nil ? userDefault.string(forKey: "fcmToken"):nil
    }
}
