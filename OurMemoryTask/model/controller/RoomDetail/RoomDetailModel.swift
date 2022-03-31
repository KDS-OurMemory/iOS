//
//  RoomDetailModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/26.
//

import UIKit

enum ROOMDETAIL_RESULT {
    case UPDATEDATA
    case UPDATEYEARMONTH
    case UPDATEIDXSCHEDULE
    case UPDATEIDXSSCHEDULE
    case UPDATESELECTDAYSCHEDULE
    case UPDATESELECTDAY
    case CHANGE
    case MOVESCHEDULEDETAILE
    case UPDATEROOMSDATA
}

class RoomDetailModel: NSObject {

    var roomDetailBlock:((ROOMDETAIL_RESULT,Any?) -> Void)?
    var roomData:roomData?
    var calData:CalendarData?
    var selectedIndex:Int = -1
    
    func initRoomDetailDataWithBlock(data:Any?, block:@escaping (ROOMDETAIL_RESULT,Any?) -> Void) {
        roomDetailBlock = block
        
        if let data = data as? roomData,let block = self.roomDetailBlock {
            roomData = data
            block(.UPDATEROOMSDATA,data)
        }
        
    }
    
    func setCalenderData(year:String,month:String,selectDates:[CalDateData]) {
        if let block = self.roomDetailBlock {
            block(.UPDATEYEARMONTH,(year,month))
        }
        calData = CalendarData(year: year, month: month, selectDay: selectDates)
        if var cal = self.calData {
            if (cal.selectDay.contains(where: {$0.getDateState() == .today})) {
                self.selectedIndex = (cal.selectDay.firstIndex(where: {$0.getDateState() == .today}))!
            }else {
                self.selectedIndex = (cal.selectDay.firstIndex(where: {$0.getDateState() == .current}))!
            }
            cal.selectDay[selectedIndex].isSelecte = true
            self.calData = cal
            if let block = self.roomDetailBlock {
                block(.UPDATEIDXSCHEDULE,self.selectedIndex)
                block(.UPDATESELECTDAYSCHEDULE,self.calData?.selectDay[selectedIndex].schedules)
                block(.UPDATESELECTDAY,self.calData?.selectDay[selectedIndex])
            }
        }
        
    }
    
    func selectIndex(index:Int) {
        if var cal = self.calData {
            cal.selectDay[self.selectedIndex].isSelecte = false
            cal.selectDay[index].isSelecte = !(cal.selectDay[index].isSelecte)
            self.calData = cal
            if let block = self.roomDetailBlock {
                block(.CHANGE,cal.selectDay)
                block(.UPDATEIDXSSCHEDULE,[self.selectedIndex,index])
                block(.UPDATESELECTDAYSCHEDULE,cal.selectDay[index].schedules)
                selectedIndex = index
                
            }
        }
        
    }
    
    func selectScheduleIndex(index:Int) {
     
        if let block = self.roomDetailBlock {
            block(.MOVESCHEDULEDETAILE,self.calData?.selectDay[selectedIndex].schedules[index])
        }
    }
    
}
