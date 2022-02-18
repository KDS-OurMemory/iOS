//
//  ScheduleDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/09.
//

import Foundation
import UIKit

public protocol ScheduleDataBinder {
    func getDates()->[ScheduleTimeDataBinder]
    func getContents()->[String]
    func getLocations()->[String]
    func getAlarm()->[String]
    func getColor()->UIColor
}
