//
//  interface.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/16.
//

import Foundation

public protocol SignupUserDataBinder {
    func getName() -> String?
    func getBirthday() -> String?
    func getBirthdayOpen() -> Bool?
    func getSolar() -> Bool?
    func getSnsId() -> String
    func getSnsType() -> SNSTYPE
}

public protocol ScheduleTimeDataBinder {
    func getYear() -> String?
    func getMonth() -> String?
    func getDay() -> String?
    func getOur() -> String?
    func getMin() -> String?
    func getWeekDay() -> String?
    func getComponents() -> DateComponents?
}
