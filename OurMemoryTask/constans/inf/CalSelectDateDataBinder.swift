//
//  calDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/01.
//

import Foundation

public enum dateState {
    case prev
    case current
    case next
    case today
    case unknown
}

public protocol CalSelectDateDataBinder {
    func getDateNum() -> String
    func getDateState() -> dateState
    func getWeeksDay() -> WEEKDAYS
    func getWeekPoint() -> Int
    func getIsSelcted() -> Bool
    func getSchedule() -> [ScheduleDateDataBinder]?
    func getSelectDateString() -> String
}
