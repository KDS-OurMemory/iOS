//
//  SelectCalModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

enum SELECTCALMODELRESULT {
    case UPDATESELECTINFO
    case CHANGE
    case UPDATEIDX
    case UPDATEIDXS
}

class SelectCalModel: NSObject {

    var selectCalModelBlock:((SELECTCALMODELRESULT,Any?) -> Void)?
    var calData:CalendarData?
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    let inqueryScheduleNetModel:InquiryScheduleListNetModel = InquiryScheduleListNetModel()
    var selectedIndex:Int = -1
    
    func initWithMyMemoryModelBlock(block:@escaping (SELECTCALMODELRESULT,Any?) -> Void) {
        selectCalModelBlock = block
    }
    
    func setCalenderData(year:String,month:String,selectDates:[CalDateData]) {
        calData = CalendarData(year: year, month: month, selectDay: selectDates)
        if var cal = self.calData {
            if (cal.selectDay.contains(where: {$0.getDateState() == .today})) {
                self.selectedIndex = (cal.selectDay.firstIndex(where: {$0.getDateState() == .today}))!
            }else {
                self.selectedIndex = (cal.selectDay.firstIndex(where: {$0.getDateState() == .current}))!
            }
            cal.selectDay[selectedIndex].isSelecte = true
            self.calData = cal
            if let block = self.selectCalModelBlock {
                block(.UPDATESELECTINFO,cal.selectDay[selectedIndex])
                block(.CHANGE,cal.selectDay)
                block(.UPDATEIDX,self.selectedIndex)
            }
        }
        
    }
    
    func selectIndex(index:Int) {
        if var cal = self.calData {
            cal.selectDay[self.selectedIndex].isSelecte = false
            cal.selectDay[index].isSelecte = !(cal.selectDay[index].isSelecte)
            self.calData = cal
            if let block = self.selectCalModelBlock {
                block(.CHANGE,cal.selectDay)
                block(.UPDATEIDX,[self.selectedIndex,index])
                selectedIndex = index
                
            }
        }
    }
}
