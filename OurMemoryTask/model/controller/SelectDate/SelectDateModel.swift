//
//  SelectDateModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/18.
//

import UIKit

enum SELECTDATE_RESULT {
    case UPDATE_SELECTDATE
    case UPDATE_SELECTEDDATE
    case VALIDECHECK_CONFIRMBTN
}

class SelectDateModel: NSObject {
    
    var selectDateCheck:SELECTDATE_CHECK = []
    var callback:((SELECTDATE_RESULT,Any?)->Void)?
    let addScheduleNetModel:AddScheduleNetModel = AddScheduleNetModel()
    var schedultTime:ScheduleTimeData!
    var year:String!
    var month:String!
    var day:String!
    var our:String!
    var min:String!
    var weekDay:String!
    var components:DateComponents!
    
    
    func initDataWithCallback(data:Any?,callback:@escaping (SELECTDATE_RESULT,Any?) -> Void) {
        self.callback = callback
        if let data = data as? [ScheduleTimeDataBinder], data.count > 0{
            if let callback = self.callback{
                callback(.UPDATE_SELECTEDDATE,data)
            }
        }
        self.valideCheckScheduleDate()
    }
    
    func setYear(year:String) {
        self.year = year
        selectDateCheck.insert(.SELECTDATE_YEAR)
        self.valideCheckScheduleDate()
    }
    
    func setMonth(month:String) {
        self.month = month
        selectDateCheck.insert(.SELECTDATE_MONTH)
        self.valideCheckScheduleDate()
    }
    
    func setDay(day:String) {
        self.day = day
        selectDateCheck.insert(.SELECTDATE_DAY)
        self.valideCheckScheduleDate()
    }
    
    func setWeekDay(weekDay:String) {
        self.weekDay = weekDay
        selectDateCheck.insert(.SELECTDATE_WEEKDAY)
    }
    
    func setOur(our:String) {
        self.our = our
        selectDateCheck.insert(.SELECTDATE_OUR)
        self.valideCheckScheduleDate()
    }
    
    func setMin(min:String) {
        self.min = min
        selectDateCheck.insert(.SELECTDATE_MIN)
        self.valideCheckScheduleDate()
    }
    
    func setDateComponents(datecomponents:DateComponents) {
        self.components = datecomponents
        selectDateCheck.insert(.SELECTDATE_COMPONENTS)
        self.valideCheckScheduleDate()
    }
    
    func tryGetScheduleTimeData() {
        if let block = self.callback {
            block(.UPDATE_SELECTDATE,schedultTime)
        }
    }
    
    func makeScheduleTimeData() {
        schedultTime = ScheduleTimeData(year: self.year, month: self.month, day: self.day, our: self.our, min: self.min,weekDay: self.weekDay,components: self.components)
    }
    
    func valideCheckScheduleDate() {
        if selectDateCheck.contains([.SELECTDATE_YEAR,.SELECTDATE_MONTH,.SELECTDATE_DAY,.SELECTDATE_OUR,.SELECTDATE_MIN,.SELECTDATE_WEEKDAY,.SELECTDATE_COMPONENTS]) {
            self.makeScheduleTimeData()
            if let block = self.callback {
                block(.VALIDECHECK_CONFIRMBTN,true)
            }
            
        }else {
            if let block = self.callback {
                block(.VALIDECHECK_CONFIRMBTN,false)
            }
        }
    }
    
    
}
