//
//  MyMemoryCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class MyMemoryCtl: BaseCollectionCtl {
    
    let myMemoryModel:MyMemoryModel = MyMemoryModel()
    let dateModel:DateComponentsModel = DateComponentsModel()
    
    override func __initWithData__(data: Any?) {
        
        self.myMemoryModel.initWithMyMemoryModelBlock { p1, p2 in
            switch p1 {
            case.UPDATEYEARMONTH:
                self.callUpdateYearMonth(yearMonth: p2 as! (String,String))
                break
            case .CHANGE:
                if let setAdapter = self.adapter {
                    setAdapter.changeData(section: 0, data: p2 as! [CalDateData])
                }
                break
            case .UPDATEIDXSCHEDULE:
                if let setAdapter = self.adapter {
                    setAdapter.reloadCollectionViewAtRow(row: p2 as! Int, atSection: 0)
                }
                break
            case .UPDATEIDXSSCHEDULE:
                if let setAdapter = self.adapter {
                    setAdapter.reloadCollectionViewAtRows(rows: p2 as! [Int], atSection: 0)
                }
                break
            case .UPDATESELECTDAYSCHEDULE:
                self.callUpdateScheduleDatas(datas: p2 as! [ScheduleDateDataBinder]?)
                break
            case .MOVESCHEDULEDETAILE:
                self.callShowNextVC(view: .NEXTVIEW_ADDSCHEDULE, data: p2 as! scheduleData)
                break
            case .UPDATESELECTDAY:
                self.callUpdateSelectDayInfo(data: p2 as! CalDateData)
                break
            }
            
        }
        
        self.dateModel.initWithCallback { p1, p2 in
            switch p1 {
            case .SELECTDATE:
                self.myMemoryModel.setCalenderData(year: "\(self.dateModel.getYear()!)", month: "\(self.dateModel.getMonth()!)", selectDates: p2 as! [CalDateData])
                self.reloadView()
                break
            }
        }
    }
    
    fileprivate func callUpdateYearMonth(yearMonth:(String,String)) {
        if let view = self.view as? MyMemoryView {
            view.updateYearMonth(yearMonth: yearMonth)
        }
    }
    
    fileprivate func callUpdateScheduleDatas(datas:[ScheduleDateDataBinder]?) {
        if let view = self.view as? MyMemoryView {
            view.updateScheduleDatas(datas: datas)
        }
    }
    
    fileprivate func callUpdateSelectDayInfo(data:CalDateData) {
        if let view = self.view as? MyMemoryView {
            view.updateSelectDay(day: data.getDateNum())
//            let lunarDate = data.getSelectDateString().dateConvertLunarComponents(dateFormatStr: "yyyy-MM-dd HH:mm")
//            view.updateSelectDayLunar(lunar: "음력 \(lunarDate.month!).\(lunarDate.day!)")
        }
    }
}


extension MyMemoryCtl:MyMemoryContract {
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.setData(section: 0, data: self.dateModel.getCalendarDate())
            
            setAdapter.setOnOffBtnBlock { p1, p2 in
                if p1 {
                    self.myMemoryModel.selectIndex(index: p2.row)
                }
            }
        }
    }
    
    func reloadView() {
        self.myMemoryModel.tryInqueryScheduleRequest(context: self)
    }
    
    func selectScheduleIndex(index:Int) {
        self.myMemoryModel.selectScheduleIndex(index: index)
    }
    
    func actionCalPlusBtn(sender:UIButton) {
        self.dateModel.changeNextDate()
    }
    
    func actionCalMinusBtn(sender:UIButton) {
        self.dateModel.changePrevDate()
    }
    
    func actionAddSchduleBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTVIEW_ADDSCHEDULE, data: nil)
        }
    }
    
    func actionSelectSharedBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTViEW_SHAREDLIST, data: nil)
        }
    }
}
