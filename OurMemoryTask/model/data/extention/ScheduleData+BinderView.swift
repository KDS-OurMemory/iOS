//
//  ScheduleData+BinderView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/09.
//

import Foundation
import UIKit

extension ScheduleData:ScheduleDataBinder {
    
    func getDates() -> [ScheduleTimeDataBinder] {
        self.date
    }
    
    func getContents() -> [String] {
        self.contents
    }
    
    func getLocations() -> [String] {
        self.locations
    }
    
    func getAlarm() -> [String] {
        self.alarms
    }
    
    func getColor() -> UIColor {
        self.color
    }
    
    
}
