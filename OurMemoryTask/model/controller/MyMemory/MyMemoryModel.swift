//
//  MyMemoryModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/02.
//

import UIKit

enum MYMEMORYMODELRESULT {
    case UPDATEYEARMONTH
    case CHANGE
    case UPDATEIDXSCHEDULE
    case UPDATEIDXSSCHEDULE
    case UPDATESELECTDAYSCHEDULE
    case MOVESCHEDULEDETAILE
    case UPDATESELECTDAY
}

class MyMemoryModel: NSObject {

    var myMemoryModelBlock:((MYMEMORYMODELRESULT,Any?) -> Void)?
    var calData:CalendarData?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let inqueryScheduleNetModel:InquiryScheduleListNetModel = InquiryScheduleListNetModel()
    var selectedIndex:Int = -1
    
    func initWithMyMemoryModelBlock(block:@escaping (MYMEMORYMODELRESULT,Any?) -> Void) {
        myMemoryModelBlock = block
    }
    
    func setCalenderData(year:String,month:String,selectDates:[CalDateData]) {
        if let block = self.myMemoryModelBlock {
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
            if let block = self.myMemoryModelBlock {
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
            if let block = self.myMemoryModelBlock {
                block(.CHANGE,cal.selectDay)
                block(.UPDATEIDXSSCHEDULE,[self.selectedIndex,index])
                block(.UPDATESELECTDAYSCHEDULE,cal.selectDay[index].schedules)
                selectedIndex = index
                
            }
        }
        
    }
    
    func selectScheduleIndex(index:Int) {
        if let block = self.myMemoryModelBlock {
            block(.MOVESCHEDULEDETAILE,self.calData?.selectDay[selectedIndex].schedules[index])
        }
    }
    
    func tryInqueryScheduleRequest(context:DataContract) {
        self.inqueryScheduleNetModel.setRequestQueryParams(params: [
            "writerId":self.sharedUserDataModel.userData.userId
        ])
        
        self.inqueryScheduleNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[scheduleData]>, Error>) in
            switch data {
            case .success(let success):
                if let response = success.response {
                    var findIdxArr:[Int] = []
                    for schedule in response {
                        
                        if let selectCaldays = self.calData?.selectDay {
                            let strIndex = schedule.startDate.index(schedule.startDate.startIndex, offsetBy: 9)
                            let responseSchedule = schedule.startDate[...strIndex]
                            guard let findIndex = selectCaldays.firstIndex(where: {$0.dateString == String(responseSchedule)})else {break}
                            findIdxArr.append(findIndex)
                            if !selectCaldays[findIndex].schedules.contains(where: {$0.memoryId == schedule.memoryId}) {
                                self.calData?.selectDay[findIndex].schedules.append(schedule)
                            }
                            
                        }
                    }
                    if let block = self.myMemoryModelBlock {
                        block(.CHANGE,self.calData?.selectDay)
                        block(.UPDATEIDXSSCHEDULE,findIdxArr)
                    }
                }
                break
            default:
                break
            }
        }
    }
    
}
