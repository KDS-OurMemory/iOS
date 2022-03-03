//
//  SignupModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/16.
//

import UIKit

enum SIGNUP_RESULT {
    case SIGNUP_VALIDCHACK
    case SIGNUP_SUCCESS
    case SIGNUP_UPDATENAME
    case SIGNUP_UPDATEBIRTHDAY
    case SIGNUP_UPDATEBIRTHDAYOPEN
    case SIGNUP_UPDATESOLAR
    case SIGNUP_UPDATEDATEMONTH
    case SIGNUP_UPDATEDATEDAY
    case DISCONNECT_SNS
}

class SignupModel: NSObject {

    var callback:((SIGNUP_RESULT,Any?)-> Void)!
    let saveDataModel:AppSaveDataModel = AppSaveDataModel()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let signupIdNetModel:SignUpIdNetModel = SignUpIdNetModel()
    var signupValidChack:SIGNUP_CHECK = []
    let snsTypeCheck:Int32 = SNSTYPE.GOOGLE.rawValue|SNSTYPE.KAKAO.rawValue|SNSTYPE.NAVER.rawValue
    var currentSnsType:SNSTYPE!
    var selectBirthdayMonth:String = ""
    var selectBirthdayDay:String = ""
    var signupParams:[String:Any] = [:]
    
    let dateFormatterGet = DateFormatter()
    
    func initWithData(data:Any?,callback: @escaping (SIGNUP_RESULT,Any?) -> Void) {
        self.callback = callback
        self.setDateFormat(dateFormat: "MMDD")
        self.setBirthdayOpenState(state: true)
        self.setSolar(solar: true)
        signupParams["pushToken"] = saveDataModel.useFCMTokenData()
        signupParams["push"] = saveDataModel.usePushTokenAllow()
        signupParams["deviceOs"] = "IOS"
        signupParams["role"] = "USER"
        signupValidChack.insert(.SIGNUP_DEVICEOS)
        signupValidChack.insert(.SIGNUP_ROLE)
        if let data = data as? SignupUserDataBinder {
            self.setSnsId(snsId: data.getSnsId())
            self.setSnsType(snsType: data.getSnsType())
            if let birthday = data.getBirthday() {
                self.setBirthday(birthday: birthday)
            }
            if let birthdayOpen = data.getBirthdayOpen() {
                self.setBirthdayOpenState(state: birthdayOpen)
            }
            if let name = data.getName() {
                if name != "" {
                    self.setName(name: name)
                }
                
            }
            
        }
    }
    
    func trySignupRequest(context:DataContract) {
        signupIdNetModel.setRequestBodyParams(params: signupParams)
        signupIdNetModel.reqeustRestFulApi(context: context) { (data:Result<json<userData>,Error>) in
            switch(data) {
            case .success(let responseData):
                if let response = responseData.response {
                    let userData = response
                    self.sharedUserDataModel.saveUserData(userData: userData)
                    self.callback(.SIGNUP_SUCCESS,userData)
                }
                break
            default:
                break
            }
        }
    }
    
    func disconnectSnsLogin() {
        sharedUserDataModel.clearData()
        switch currentSnsType {
        case .UNOWNED:
            break
        case .KAKAO:
            KaKaoLoginWrapper.shared.dissConnectionKakao()
            break
        case .NAVER:
            break
        case .GOOGLE:
            break
        case .none:
            break
        
        }
        self.callback(.DISCONNECT_SNS,nil)
    }
    
    fileprivate func setBirthday(birthday:String) {
        if dateFormatterGet.date(from: birthday) != nil {
            signupParams["birthday"] = birthday
            signupValidChack.insert(.SIGNUP_BIRTHDAY)
            
//            self.callback(.SIGNUP_UPDATEBIRTHDAY,birthday)
            
            self.valideCheckSignUp()
        }else {
            signupValidChack.remove(.SIGNUP_BIRTHDAY)
        }
    }
    
    func getBirthday() {
        let birthday = signupParams["birthday"]
        if birthday != nil {
            self.callback(.SIGNUP_UPDATEBIRTHDAY,birthday)
        }
    }
    
    func clearUserData() {
        sharedUserDataModel.clearData()
        saveDataModel.clearData()
    }
    
    func setSelectMonth(month:String) {
        self.selectBirthdayMonth = month
//        self.callback(.SIGNUP_UPDATEDATEMONTH,month)
        if (self.selectBirthdayMonth.count > 0 && self.selectBirthdayDay.count > 0) {
            self.setBirthday(birthday: self.selectBirthdayMonth+self.selectBirthdayDay)
        }
    }
    
    func setSelectDay(day:String) {
        self.selectBirthdayDay = day
//        self.callback(.SIGNUP_UPDATEDATEDAY,day)
        if (self.selectBirthdayMonth.count > 0 && self.selectBirthdayDay.count > 0) {
            self.setBirthday(birthday: self.selectBirthdayMonth+self.selectBirthdayDay)
        }
    }
    
    func setName(name:String) {
        if name.count > 0 {
            signupParams["name"] = name
            signupValidChack.insert(.SIGNUP_NAME)
            self.callback(.SIGNUP_UPDATENAME,name)
            self.valideCheckSignUp()
        }else {
            signupValidChack.remove(.SIGNUP_NAME)
        }
    }
    
    func setBirthdayOpenState(state:Bool) {
        signupParams["birthdayOpen"] = state
        signupValidChack.insert(.SIGNUP_BIRTHDAYOPEN)
        self.callback(.SIGNUP_UPDATEBIRTHDAYOPEN,state)
        self.valideCheckSignUp()
        
    }
    
    func setSnsId(snsId:String) {
        if snsId.count > 0 {
            signupParams["snsId"] = snsId
            signupValidChack.insert(.SIGNUP_SNSID)
            self.valideCheckSignUp()
        }
    }
    
    func setSnsType(snsType:SNSTYPE) {
        self.currentSnsType = snsType
        if snsTypeCheck & snsType.rawValue == snsType.rawValue {
            signupParams["snsType"] = snsType.rawValue
            signupValidChack.insert(.SIGNUP_SNSTYPE)
            self.valideCheckSignUp()
        }
        
    }
    
    func setSolar(solar:Bool) {
        signupParams["solar"] = solar
        signupValidChack.insert(.SIGNUP_SOLAR)
        self.callback(.SIGNUP_UPDATESOLAR,solar)
        self.valideCheckSignUp()
    }
    
    func setDateFormat(dateFormat:String) {
        dateFormatterGet.dateFormat = dateFormat
    }
    
    func valideCheckSignUp() {
        if signupValidChack.contains([.SIGNUP_BIRTHDAY,.SIGNUP_SOLAR,.SIGNUP_SNSID,.SIGNUP_SNSTYPE,.SIGNUP_DEVICEOS,.SIGNUP_NAME,.SIGNUP_ROLE])  {
            self.callback(.SIGNUP_VALIDCHACK,true)
        }else {
            self.callback(.SIGNUP_VALIDCHACK,false)
        }
    }
    
}
