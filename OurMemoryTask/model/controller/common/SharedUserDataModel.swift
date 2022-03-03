//
//  SharedUserDataModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//


public class SharedUserDataModel: NSObject {
    
    static let sharedUserData = SharedUserDataModel()
    
    let appSaveDataModel:AppSaveDataModel = AppSaveDataModel()
    var userData:userData!
    
    func saveUserData(userData:userData) {
        
        self.userData = userData
        userData.getProfileImage { p1 in
            self.userData.profileImage = p1
        }

        self.appSaveDataModel.saveSnsIDData(userSnsID: "\(userData.snsId)")
        self.appSaveDataModel.saveUserIDData(userID: "\(userData.userId)")
        self.appSaveDataModel.saveFCMTokenData(fcmToken: userData.pushToken)
    }

    func clearData() {
        
        
    }

}
