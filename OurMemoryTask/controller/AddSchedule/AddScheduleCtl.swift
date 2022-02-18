//
//  AddScheduleCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class AddScheduleCtl: BaseCtl {

    let addScheduleModel:AddScheduleModel = AddScheduleModel()
    
    override func __initWithData__(data: Any?) {
        addScheduleModel.initWithBlock(data:data) { p1, p2 in
            switch p1 {
            case .SCHEDULE_UPDATE:
                self.callUpdateScehduleData(dataBinder: p2 as! ScheduleDataBinder)
                break
            case .SCHEDULE_UPDATE_SELECTED_DATE:
                self.callShowSelectdDatePicker(date: p2 as! ScheduleDataBinder)
                break
            case .SCHEDULEALARMTIME_UPDATE:
                self.callUpdateAlram(alarm: p2 as! String)
                break
            case .SCHEDULECOLOR_UPDATE:
                self.callUpdateColor(color: p2 as! UIColor)
                break
            case .SCHEDULECONFIRMBTN_UPDATE:
                self.callUpdateConfirmBtnState(state: p2 as! Bool)
                break
            }
        }
        
        self.callUpdateConfirmBtnState(state: false)
        
    }
    
    
    fileprivate func callUpdateColor(color:UIColor) {
        if let view = self.view as? AddScheduleView {
            view.updateColor(color: color)
        }
    }
    
    fileprivate func callUpdateAlram(alarm:String) {
        if let view = self.view as? AddScheduleView {
            view.updateAlarm(alarm: alarm)
        }
    }
    
    fileprivate func callUpdateConfirmBtnState(state:Bool ) {
        if let view = self.view as? AddScheduleView {
            view.updaetConfirmBtnState(state: state )
        }
     }
    
    fileprivate func callUpdateScehduleData(dataBinder:ScheduleDataBinder) {
        if let view = self.view as? AddScheduleView {
            view.updateScheduleData(dataBinder: dataBinder)
        }
    }
    
    fileprivate func callShowSelectdDatePicker(date:ScheduleDataBinder) {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_SELECTDATE, data: date.getDates())
        }
    }
}


extension AddScheduleCtl: AddScheduleContract {
    
    func setScheduleTitle(title: String) {
        addScheduleModel.setTitle(title: title)
    }
    
    func addDate(date:ScheduleTimeDataBinder) {
        addScheduleModel.addDate(date: date)
    }
    
    func addContent(content:String) {
        addScheduleModel.addContent(content: content)
    }
    
    func addLocation(location:String) {
        addScheduleModel.addLocation(location: location)
    }
    
    func setAlarm(alarm:String) {
        addScheduleModel.setAlarm(alarm: alarm)
    }
    
    func setColor(color:UIColor) {
        addScheduleModel.setColor(color: color)
    }
    
    func actionDatesView() {
        addScheduleModel.getSelectedDate()
    }
    
    func actionAlarmsView() {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_SELECTALRAMTIME, data: self.addScheduleModel.alrams)
        }
    }
    
    func actionContentsView() {
        if let view = self.view as? AddScheduleView {
//            view.showNextVC(vc: .NEXTVIEW_CO, data: <#T##[NSObject]?#>)
        }
    }
    
    func actionLocationsView() {
        if let view = self.view as? AddScheduleView {
            
        }
    }
    
    func actionColorView() {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_SELECTCOLOR, data: nil)
        }
    }
    
    func actionSharedView() {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTViEW_SHAREDLIST, data: nil)
        }
    }
    
    func actionConfirmBtn(sender:UIButton) {
        if let view = self.view as? AddScheduleView {
            view.showAlertMsgWithTitleAndActions(title: "일정 등록", msg: "일정을 등록 하시겠습니까?", actions:  ["확인":{ p1 in
                self.addScheduleModel.tryAddScheduleRequest(context: self)
            },"취소":{ p1 in
                
            }])
        }
    }
    
    func actionCloseBtn(sender:UIButton) {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
    }
    
}
