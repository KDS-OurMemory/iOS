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
        addScheduleModel.initWithBlock { p1, p2 in
            switch p1 {
            case .SCHEDULE_UPDATE:
                self.callUpdateScehduleData(dataBinder: p2 as! ScheduleDataBinder)
                break
            case .SCHEDULE_UPDATE_SELECTED_DATE:
                self.callShowSelectdDatePicker(date: p2 as! ScheduleDataBinder)
                break
            }
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
    
    func addDate(date:String) {
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
    
    func actionDatesView(sender:UIView) {
        addScheduleModel.getSelectedDate()
    }
    
    func actionContentsView(sender:UIView) {
        if let view = self.view as? AddScheduleView {
//            view.showNextVC(vc: .NEXT, data: <#T##[NSObject]?#>)
        }
    }
    
    func actionLocationsView(sender:UIView) {
        if let view = self.view as? AddScheduleView {
            
        }
    }
    
    func actionColorView(sender:UIView) {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_SELECTCOLOR, data: nil)
        }
    }
    
    func actionSharedView(sender:UIView) {
        if let view = self.view as? AddScheduleView {
//            view.showNextVC(vc: .NEXTViEW_SHAREDLIST, data: <#T##[NSObject]?#>)
        }
    }
    
    func actionConfirmBtn(sender:UIButton) {
        if let view = self.view as? AddScheduleView {
            
        }
    }
    
    func actionCloseBtn(sender:UIButton) {
        if let view = self.view as? AddScheduleView {
            view.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
    }
    
}
