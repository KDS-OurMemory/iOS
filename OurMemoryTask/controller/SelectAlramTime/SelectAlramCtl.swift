//
//  SelectAlramCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit

class SelectAlramCtl: BaseCtl {

    let selectAlarmModel:SelectAlarmModel = SelectAlarmModel()
    
    override func __initWithData__(data: Any?) {
        selectAlarmModel.initWithCallback { p1, p2 in
            let result = SELECTALARM_RESULT.init(rawValue: p1)
            switch result {
            case .SELECTED_ALARMLIST_UPDATE:
                break
            case .SELECTED_ALARMTITLE_UPDATE:
                self.callApplySelectedAlarms(alarms: p2 as! String)
                break
            case .SELECTED_ALARM_OVERSELECTED:
                self.view.showFadeOutMsgView(msg: "최대 2개의 알람만 선택하실 수 있습니다.")
                break
            case .SELECTE_ALARMINDEX:
                self.callUpdateEnableSelectedAlarmIndex(idx: p2 as! Int)
                break
            case .DISABLE_ALARMINDEX:
                self.callUpdatedisableSelectedAlarmIndex(idx: p2 as! Int)
                break
            case .SELECTED_SUCCESS:
                self.callApplySelectedAlarms(alarms: p2 as! String)
                break
            case .SELECTED_FAILE:
                self.callShowNextVC(view: .NEXTVIEW_POP, data: nil)
                break
            case .none:
                break
            }
        }
    }
    
    fileprivate func callUpdateAlarmList(alarmList:[String]) {
        if let view = self.view as? SelectAlramView {
            view.updateAlarmList(alarmList: alarmList)
        }
    }
    
    fileprivate func callUpdateSelectedAlarmTitle(title:String) {
        if let view = self.view as? SelectAlramView {
            view.updateSelectedAlarmTitle(title: title)
        }
    }
    
    fileprivate func callUpdateEnableSelectedAlarmIndex(idx:Int) {
        if let view = self.view as? SelectAlramView {
            view.enableSelectedAlarmIndex(idx: idx)
        }
    }
    
    fileprivate func callUpdatedisableSelectedAlarmIndex(idx:Int) {
        if let view = self.view as? SelectAlramView {
            view.disableSelectedAlarmIndex(idx: idx)
        }
    }
    
    fileprivate func callApplySelectedAlarms(alarms:String) {
        if let view = self.view as? SelectAlramView {
            view.applySelectedAlarms(alarms: alarms)
        }
    }
    
}

extension SelectAlramCtl: SelectAlramContract {
    
    func selectAlarmIdx(idx:Int) {
        self.selectAlarmModel.selectAlarmIndex(index: idx)
    }
}
