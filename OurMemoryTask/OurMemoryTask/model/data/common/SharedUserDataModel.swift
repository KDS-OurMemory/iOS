//
//  SharedUserDataModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/02.
//


public class SharedUserDataModel: NSObject {
    
    
    public static let sharedUserData = SharedUserDataModel()
    
    let appSaveDataModel:AppSaveDataModel = AppSaveDataModel()

    var userId:Int?
    var snsId:String?
    var snsType:Int?
    var pushToken:String?
    var name:String?
    var birthDay:String?
    var isSolar:Bool?
    var isBirthdayOpen:Bool?
    let deviceOs:String = "iOS"
    
    
    public func saveUserData(user:userData?) {
        if let user = user
        {
            self.userId = user.userId
            self.snsType = appSaveDataModel.useSnsTypeData()
            self.pushToken = appSaveDataModel.useFCMTokenData()
            self.name = user.name
            self.birthDay = user.birthday
            self.isSolar = user.solar
            self.isBirthdayOpen = user.birthdayOpen
        }
        
    }
    
    public func saveUserData(snsId : String,snsType : Int,pushToken : String,name : String,birthday : String?,isSolar : Bool?,isBirthdayOpen : Bool?) {
        
        self.snsId = snsId
        self.snsType = snsType
        self.pushToken = pushToken
        self.name = name
        self.birthDay = birthday == nil ? nil : birthday
        self.isSolar = isSolar == nil ? false : isSolar
        self.isBirthdayOpen = isBirthdayOpen == nil ? false : isBirthdayOpen
        
    }
    
    public func clearData() {
        self.userId = nil
        self.snsType = nil
        self.pushToken = nil
        self.name = nil
        self.birthDay = nil
        self.isSolar = nil
        self.isBirthdayOpen = nil
    }
    
    public func setName(name:String) {
        self.name = name
    }
    
    public func getName() -> String? {
        return self.name == nil ? nil : self.name
    }
    
    public func setBirthday(birthday:String) {
        self.birthDay = birthday
    }
    
    public func getBirthday() -> String? {
        return self.birthDay == nil ? nil:self.birthDay
    }
}
