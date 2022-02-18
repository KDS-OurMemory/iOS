//
//  SelectAlramCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit

class SelectAlarmCtl: BaseCtl {

    let selectAlarmModel:SelectAlarmModel = SelectAlarmModel()
    
    override func __initWithData__(data: Any?) {
        selectAlarmModel.initWithCallback(data:data) { p1, p2 in
            let result = SELECTALARM_RESULT.init(rawValue: p1)
            switch result {
            case .SELECTED_APPLYALARMLIST_UPDATE:
                self.callApplySelectedAlarms(alarms: p2 as! String)
                break
            case .SELECTED_ALARMLIST_UPDATE:
                self.callUpdateAlarmList(alarmList: p2 as! [String])
                break
            case .SELECTED_ALARMTITLE_UPDATE:
                self.callUpdateSelectedAlarmTitle(title: p2 as! String)
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
            case .DISMISS_POPUP:
                self.callDismissPopup()
                break
            case .none:
                break
            }
        }
    }
    
    fileprivate func callDismissPopup() {
        if let view = self.view as? SelectAlarmView {
            view.dismissPopup()
        }
    }
    
    fileprivate func callUpdateAlarmList(alarmList:[String]) {
        if let view = self.view as? SelectAlarmView {
            view.updateAlarmList(alarmList: alarmList)
        }
    }
    
    fileprivate func callUpdateSelectedAlarmTitle(title:String) {
        if let view = self.view as? SelectAlarmView {
            view.updateSelectedAlarmTitle(title: title)
        }
    }
    
    fileprivate func callUpdateEnableSelectedAlarmIndex(idx:Int) {
        if let view = self.view as? SelectAlarmView {
            view.enableSelectedAlarmIndex(idx: idx)
        }
    }
    
    fileprivate func callUpdatedisableSelectedAlarmIndex(idx:Int) {
        if let view = self.view as? SelectAlarmView {
            view.disableSelectedAlarmIndex(idx: idx)
        }
    }
    
    fileprivate func callApplySelectedAlarms(alarms:String) {
        if let view = self.view as? SelectAlarmView {
            view.applySelectedAlarms(alarms: alarms)
        }
    }
    
}

extension SelectAlarmCtl: SelectAlarmContract {
    
    func actionConfirmBtn(sender: UIButton) {
        self.selectAlarmModel.tryGetApplyedAlarm()
    }
    
    func actionCancelBtn(sender: UIButton) {
        if let view = self.view as? SelectAlarmView {
            view.dismissPopup()
        }
    }
    
    func selectAlarmIdx(idx:Int) {
        self.selectAlarmModel.selectAlarmIndex(index: idx)
    }
}
