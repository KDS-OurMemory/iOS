//
//  AddScheduleModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/09.
//

import UIKit

enum SCHEDULERESULT {
    case SCHEDULE_UPDATE
    case SCHEDULE_UPDATE_SELECTED_DATE
}

class AddScheduleModel: NSObject {

    var scheduleData:ScheduleData = ScheduleData()
    
    var scheduleBlock:((SCHEDULERESULT,Any?) -> Void)?

    func initWithBlock(block:@escaping (SCHEDULERESULT,Any)->Void) {
        scheduleBlock = block
    }
    
    func setTitle(title:String) {
        scheduleData.title = title
    }
    
    func addDate(date:String) {
        scheduleData.date.append(date)
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func addContent(content:String) {
        scheduleData.contents.append(content)
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func addLocation(location:String) {
        scheduleData.locations.append(location)
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func setAlarm(alarm:String) {
        scheduleData.alarm = alarm
    }
    
    func setColor(color:UIColor) {
        scheduleData.color = color
    }
    
    func getSelectedDate() {
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE_SELECTED_DATE,scheduleData)
        }
    }
}
