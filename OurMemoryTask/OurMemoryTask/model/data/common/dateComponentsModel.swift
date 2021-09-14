//
//  dateComponentsModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/09.
//

import UIKit

class dateComponentsModel: NSObject {
    var date = Date();
    let cal = Calendar.current;
    var components:DateComponents!

    override init() {
        super.init()
        self.components = self.cal.dateComponents([.year,.month,.day], from: self.date)
//        self.setMonthofCal()
    }
    
    func getComponentsDate() -> Date {
        if let date = self.cal.date(from: self.components)
        {
            return date
        }
        return Date()
    }
    
    func getCurrentDate() -> DateComponents {
         return self.cal.dateComponents([.year,.month,.day], from: self.date)
    }
    
    var startOfDay:Date {
        return Calendar.current.startOfDay(for: self.date)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from:  self.date)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self.startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: self.startOfMonth)!
    }
    
    var prevLastDayOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self.date)
        components.day = 0
        return calendar.date(from: components)!
    }
    
    var nextFirstDayOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self.date)
        components.month = components.month! + 1
        components.day = 1
        return calendar.date(from: components)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from:  self.date)
        return components.weekday == 2
    }
    
    func getMonth() -> Int? {
        if let month = self.components.month
        {
            return month
        }
        return nil
    }
    
    func getYear() -> Int? {
        if let year = self.components.year
        {
            return year
        }
        return nil
    }
    
    func getToday() -> Int? {
        if let day = self.getCurrentDate().day {
            return day
        }
        return nil
    }
    
    func getWeekToDay() -> Int? {
        if let weekDay = self.getCurrentDate().weekday
        {
            return weekDay
        }
        return nil
    }

    func setMonth(month:Int) {
        self.components.setValue(month, for: .month)
        if let date = self.cal.date(from: self.components) {
            self.date = date
//            self.setMonthofCal()
        }
    }
    
    func setDay(day:Int) {
        self.components.setValue(day, for: .day)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
 
    func getDayofDate(date:Date) -> Int {
        return cal.dateComponents([.day], from: date).day!
    }
    
    func getWeekDayofDate(date:Date) -> Int {
        return cal.dateComponents([.weekday], from: date).weekday!
    }
    
    func getWeekCntofMonth() -> Int {
         var calendar = Calendar(identifier: .gregorian)
         calendar.firstWeekday = 1
         let weekRange = calendar.range(of: .weekOfMonth,
                                        in: .month,
                                        for: self.date)
         return weekRange!.count
    }
    
//    func getCalendarDate() -> [calCellData] {
//        return self.monthDateCal
//    }
//
//    func getCalendarDateCnt() -> Int {
//        return self.monthDateCal.count
//    }
//
//    func setMonthofCal() {
//        self.monthDateCal.removeAll()
//        let prevWeekday = self.getWeekDayofDate(date: self.prevLastDayOfMonth)
//        if prevWeekday < 7
//        {
//            for weekDay in 1...prevWeekday {
//                let day = self.getDayofDate(date: self.prevLastDayOfMonth) - (prevWeekday - weekDay)
//                let data = calCellData(num: "\(day)", state: dateState.prev, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7)
//                self.monthDateCal.append(data);
//            }
//        }
//
//        var currentWeekDay = self.getWeekDayofDate(date: self.startOfMonth)
//        for day in self.getDayofDate(date: self.startOfMonth)...self.getDayofDate(date: self.endOfMonth) {
//            let data = calCellData(num: "\(day)", state: dateState.current, weekDay: WEEKDAYS(rawValue: Int8(currentWeekDay))!, weekPoint: self.monthDateCal.count/7)
//            if currentWeekDay == 7 {
//                currentWeekDay = 1
//            }else {
//                currentWeekDay += 1
//            }
//            self.monthDateCal.append(data)
//        }
//
//        if self.getWeekDayofDate(date: self.nextFirstDayOfMonth) > 1 {
//            var day = 1
//            for weekDay in self.getWeekDayofDate(date: self.nextFirstDayOfMonth)...7
//            {
//                let data = calCellData(num: "\(day)", state: dateState.next, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7)
//                day += 1
//                self.monthDateCal.append(data)
//            }
//        }
//    }
}

