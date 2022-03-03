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
    case UPDATEIDX
    case UPDATEIDXS
}

class MyMemoryModel: NSObject {

    var myMemoryModelBlock:((MYMEMORYMODELRESULT,Any?) -> Void)?
    var calData:CalendarData?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let inqueryScheduleNetModel:InquiryScheduleListNetModel = InquiryScheduleListNetModel()
    
    func initWithMyMemoryModelBlock(block:@escaping (MYMEMORYMODELRESULT,Any?) -> Void) {
        myMemoryModelBlock = block
    }
    
    func setCalenderData(year:String,month:String,selectDates:[CalDateData]) {
        if let block = self.myMemoryModelBlock {
            block(.UPDATEYEARMONTH,(year,month))
        }
        calData = CalendarData(year: year, month: month, selectDay: selectDates)
    }
    
    func selectIndex(index:Int) {
        self.calData?.selectDay[index].isSelecte = !(self.calData?.selectDay[index].isSelecte)!
        if let block = self.myMemoryModelBlock {
            block(.CHANGE,self.calData?.selectDay)
            block(.UPDATEIDX,index)
        }
    }
    
    func tryInqueryScheduleRequest(context:DataContract) {
        self.inqueryScheduleNetModel.setRequestQueryParams(params: [
            "writerId":self.sharedUserDataModel.userData.privateRoomId
        ])
        
        self.inqueryScheduleNetModel.reqeustRestFulApi(context: context) { (data:Result<json<[scheduleData]>, Error>) in
            switch data {
            case .success(let success):
                if let response = success.response {
                    var findIdxArr:[Int] = []
                    for schedule in response {
                        
                        if let selectCaldays = self.calData?.selectDay {
                            let strIndex = schedule.firstAlarm!.index(schedule.firstAlarm!.startIndex, offsetBy: 10)
                            let responseSchedule = schedule.firstAlarm![...strIndex]
                            guard let findSchedule = selectCaldays.first(where: {$0.dateString == responseSchedule })else {return}
                            guard let findIndex = selectCaldays.firstIndex(where: {$0.dateString == responseSchedule})else {return}
                            findIdxArr.append(findIndex)
                            self.calData?.selectDay[findIndex] = findSchedule
                        }
                    }
                    if let block = self.myMemoryModelBlock {
                        block(.CHANGE,self.calData?.selectDay)
                        block(.UPDATEIDXS,findIdxArr)
                    }
                }
                break
            default:
                break
            }
        }
    }
    
}
