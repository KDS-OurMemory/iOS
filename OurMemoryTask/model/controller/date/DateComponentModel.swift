//
//  DateComponentModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/21.
//

import Foundation

enum DATERESULT {
    case SELECTDATE
}

class DateComponentsModel: NSObject {
    var date = Date();
    let cal = Calendar.current;
    var components:DateComponents = DateComponents()
    var monthDateCal:[CalDateData] = []
    var callback:((DATERESULT,Any?) -> Void)?
    
    func initWithCallback(callback: @escaping (DATERESULT,Any?) -> Void) {
        self.callback = callback
        self.components = self.cal.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: self.date)
        self.setMonthofCal()
    }
    
    func getComponentsDate() -> Date {
        if let date = self.cal.date(from: self.components)
        {
            return date
        }
        return Date()
    }
    
    func getCurrentDate() -> DateComponents {
        return self.cal.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)
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
    
    func getYear() -> Int? {
        if let year = self.components.year
        {
            return year
        }
        return nil
    }
    
    func getMonth() -> Int? {
        if let month = self.components.month
        {
            return month
        }
        return nil
    }
    
    func getWeek() -> Int? {
        if let weekDay = self.components.weekday {
            return weekDay
        }
        return nil
    }
    
    func getWeekDayStr() -> String? {
        if let weekDay = self.components.weekday {
            var weekDayStr = ""
            switch weekDay {
            case 1:
                weekDayStr = "일"
                break
            case 2:
                weekDayStr = "월"
                break
            case 3:
                weekDayStr = "화"
                break
            case 4:
                weekDayStr = "수"
                break
            case 5:
                weekDayStr = "목"
                break
            case 6:
                weekDayStr = "금"
                break
            case 7:
                weekDayStr = "토"
                break
            default:
                break
            }
            return weekDayStr
        }
        return nil
    }
    
    func getDay() -> Int? {
        if let day = self.components.day {
            
            return day
        }
        return nil
    }
    
    func getHour() -> Int? {
        if let hour = self.components.hour {
            return hour
        }
        return nil
    }
    
    func getMin() -> Int? {
        if let min = self.components.minute {
            return min
        }
        return nil
    }
    
    func getSecond() -> Int? {
        if let sec = self.components.second {
            return sec
        }
        return nil
    }
    
    func getCurrentYear() -> Int? {
        if let year = self.getCurrentDate().year {
            return year
        }
        return nil
    }
    
    func getCurrentMonth() -> Int? {
        if let month = self.getCurrentDate().month {
            return month
        }
        return nil
    }
    
    func getCurrentWeek() -> Int? {
        if let weekDay = self.getCurrentDate().weekday
        {
            return weekDay
        }
        return nil
    }
    
    func getToday() -> Int? {
        if let day = self.getCurrentDate().day {
            return day
        }
        return nil
    }

    func setYear(year:Int) {
        self.components.setValue(year, for: .year)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
    
    func setMonth(month:Int) {
        self.components.setValue(month, for: .month)
        if let date = self.cal.date(from: self.components) {
            self.date = date
            self.setMonthofCal()
        }
    }
    
    func setDay(day:Int) {
        self.components.setValue(day, for: .day)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
    
    func setHour(hour:Int) {
        self.components.setValue(hour, for: .hour)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
    
    func setMinute(minute:Int) {
        self.components.setValue(minute, for: .minute)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
    
    func setSeconds(seconds:Int) {
        self.components.setValue(seconds, for: .second)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
    
    func setDateStrForDateFormatStr(dateStr:String,dateformatStr:String) {
        let dateformat:DateFormatter = DateFormatter()
        dateformat.dateFormat = dateformatStr
        
        var calComponentSet:Set<Calendar.Component> = []
        if dateformatStr.contains("Y")||dateformatStr.contains("y") {
            calComponentSet.insert(.year)
        }
        if dateformatStr.contains("M"){
            calComponentSet.insert(.month)
        }
        if dateformatStr.contains("D")||dateformatStr.contains("d"){
            calComponentSet.insert(.day)
        }
        if dateformatStr.contains("H"){
            calComponentSet.insert(.hour)
        }
        if dateformatStr.contains("m"){
            calComponentSet.insert(.minute)
        }
        if dateformatStr.contains("s"){
            calComponentSet.insert(.second)
        }
        
        if let date = dateformat.date(from: dateStr) {
            self.date = date
            self.components = self.cal.dateComponents(calComponentSet, from: self.date)
        }
    }

    func getDayofDate(date:Date) -> Int {
        return cal.dateComponents([.day], from: date).day!
    }
    
    func getMonthofDate(date:Date) -> Int {
        return cal.dateComponents([.month], from: date).month!
    }
    
    func getYearofDate(date:Date) -> Int {
        return cal.dateComponents([.year], from: date).year!
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
    
    func getCalendarDate() -> [CalDateData] {
        return self.monthDateCal
    }
    
    func getCalendarDateCnt() -> Int {
        return self.monthDateCal.count
    }
    
    func getDateWithDateformat(dateformatStr:String) -> String {
        let dateformat:DateFormatter = DateFormatter()
        dateformat.dateFormat = dateformatStr
        return dateformat.string(from: self.date)
    }
    
    func setMonthofCal() {
        self.monthDateCal.removeAll()
        let prevWeekday = self.getWeekDayofDate(date: self.prevLastDayOfMonth)
        if prevWeekday < 7
        {
            for weekDay in 1...prevWeekday {
                let day = self.getDayofDate(date: self.prevLastDayOfMonth) - (prevWeekday - weekDay)
                let data = CalDateData(num: "\(day)", state: dateState.prev, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7, dateString:"\(self.getYearofDate(date: self.prevLastDayOfMonth))-\(self.getMonthofDate(date: self.prevLastDayOfMonth))-\(day)")
                self.monthDateCal.append(data);
            }
        }
        
        var currentWeekDay = self.getWeekDayofDate(date: self.startOfMonth)
        for day in self.getDayofDate(date: self.startOfMonth)...self.getDayofDate(date: self.endOfMonth) {
            let isToDay = day == self.getToday()!&&self.getYearofDate(date: self.startOfMonth) == self.getCurrentYear()&&self.getMonthofDate(date: self.startOfMonth) == self.getCurrentMonth()
            let data = CalDateData(num: "\(day)", state: (isToDay ? dateState.today:dateState.current), weekDay: WEEKDAYS(rawValue: Int8(currentWeekDay))!, weekPoint: self.monthDateCal.count/7, dateString: "\(self.getYearofDate(date: self.startOfMonth))-\(self.getMonthofDate(date: self.startOfMonth))-\(day)")
            if currentWeekDay == 7 {
                currentWeekDay = 1
            }else {
                currentWeekDay += 1
            }
            self.monthDateCal.append(data)
        }
        
        if self.getWeekDayofDate(date: self.nextFirstDayOfMonth) > 1 {
            var day = 1
            for weekDay in self.getWeekDayofDate(date: self.nextFirstDayOfMonth)...7
            {
                let data = CalDateData(num: "\(day)", state: dateState.next, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7, dateString: "\(self.getYearofDate(date: self.nextFirstDayOfMonth))-\(self.getMonthofDate(date: self.nextFirstDayOfMonth))-\(day)")
                day += 1
                self.monthDateCal.append(data)
            }
        }
        
        if let callback = self.callback {
            callback(.SELECTDATE,self.monthDateCal)
        }
    }
    
    
}
