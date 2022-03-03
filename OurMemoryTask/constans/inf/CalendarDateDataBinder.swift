//
//  CalDateDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/02.
//

import Foundation

public protocol CalendarDateDataBinder {
    func getYear() -> String
    func getMonth() -> String
    func getSelectDate() -> [CalSelectDateDataBinder]
    
}
