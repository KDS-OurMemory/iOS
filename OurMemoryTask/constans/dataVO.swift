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

struct SIGNUP_CHECK:OptionSet {
    
    let rawValue: Int
    
    static let SIGNUP_UNKNOWN = 1
    static let SIGNUP_BIRTHDAY = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 1)
    static let SIGNUP_DEVICEOS = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 2)
    static let SIGNUP_NAME = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 3)
    static let SIGNUP_SNSID = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 4)
    static let SIGNUP_SNSTYPE = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 5)
    static let SIGNUP_SOLAR = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 6)
    static let SIGNUP_BIRTHDAYOPEN = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 7)
    static let SIGNUP_ROLE = SIGNUP_CHECK(rawValue: SIGNUP_UNKNOWN << 8)
    
}

struct SELECTDATE_CHECK:OptionSet {
    
    let rawValue: Int
    
    static let SELECTDATE_UNKNOWN = 1
    static let SELECTDATE_YEAR = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 1)
    static let SELECTDATE_MONTH = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 2)
    static let SELECTDATE_DAY = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 3)
    static let SELECTDATE_OUR = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 4)
    static let SELECTDATE_MIN = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 5)
    static let SELECTDATE_WEEKDAY = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 6)
    static let SELECTDATE_COMPONENTS = SELECTDATE_CHECK(rawValue: SELECTDATE_UNKNOWN << 7)
    
}

struct ADDSCHEDULE_INPUTDATA_CHECK:OptionSet {
    
    let rawValue: Int
    
    static let ADDSCHEDULE_INPUT_UNKNOWN = 1
    static let ADDSCHEDULE_INPUT_TITLE = ADDSCHEDULE_INPUTDATA_CHECK(rawValue:ADDSCHEDULE_INPUT_UNKNOWN << 1)
    static let ADDSCHEDULE_INPUT_DATE = ADDSCHEDULE_INPUTDATA_CHECK(rawValue:ADDSCHEDULE_INPUT_UNKNOWN << 2)
    static let ADDSCHEDULE_INPUT_ALARM = ADDSCHEDULE_INPUTDATA_CHECK(rawValue:ADDSCHEDULE_INPUT_UNKNOWN << 3)
    
}

struct ScheduleTimeData:ScheduleTimeDataBinder {
    
    var year:String?
    var month:String?
    var day:String?
    var our:String?
    var min:String?
    var weekDay:String?
    let components:DateComponents?
    
    init(year:String?,month:String?,day:String?,our:String?,min:String?,weekDay:String?,components:DateComponents) {
        self.year = year
        self.month = month
        self.day = day
        self.our = our
        self.min = min
        self.weekDay = weekDay
        self.components = components
    }
    
    func getYear() -> String? {
        self.year
    }
    
    func getMonth() -> String? {
        self.month
    }
    
    func getDay() -> String? {
        self.day
    }
    
    func getOur() -> String? {
        self.our
    }
    
    func getMin() -> String? {
        self.min
    }
    
    func getWeekDay() -> String? {
        self.weekDay
    }
    
    func getComponents() -> DateComponents? {
        self.components
    }
    
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

struct CalendarData {
    var year:String
    var month:String
    var selectDay:[CalDateData]
}

struct CalDateData:CalSelectDateDataBinder {
    
    let num:String
    let state:dateState
    let weekDay:WEEKDAYS
    let weekPoint:Int
    let dateString:String
    var isSelecte:Bool = false
    var schedules:[scheduleData]?
    
    func getDateNum() -> String {
        return self.num
    }
    
    func getDateState() -> dateState {
        return self.state
    }
    
    func getWeeksDay() -> WEEKDAYS {
        return self.weekDay
    }
    
    func getWeekPoint() -> Int {
        return self.weekPoint
    }
    
    func getIsSelcted() -> Bool {
        return self.isSelecte
    }
    
    func getSchedule() -> [ScheduleDateDataBinder]? {
        return self.schedules
    }
    
    func getSelectDateString() -> String {
        return self.dateString
    }
    
}
