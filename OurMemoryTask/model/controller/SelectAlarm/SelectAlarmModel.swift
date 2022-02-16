//
//  SelectDateModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/11.
//

import UIKit

enum SELECTALARM_RESULT:UInt  {
    case SELECTED_ALARM_OVERSELECTED
    case SELECTED_ALARMLIST_UPDATE
    case SELECTED_ALARMTITLE_UPDATE
    case SELECTE_ALARMINDEX
    case DISABLE_ALARMINDEX
    case SELECTED_SUCCESS
    case SELECTED_FAILE
}

class SelectAlarmModel: NSObject {

    let alarmList:[String] = ["정시","5분 전","10분 전","15분 전","30분 전","1시간 전","2시간 전","3시간 전","12시간 전","1일 전","2일 전"]
    var selectedAlarmIndexs:[Int] = []
    var selectDateCallBack:UINTANY_VOID?
    var selectedAlarm = ""
    
    func initWithCallback(callBack:@escaping UINTANY_VOID) {
        selectDateCallBack = callBack
        if let block = self.selectDateCallBack {
            block(SELECTALARM_RESULT.SELECTED_ALARMLIST_UPDATE.rawValue,alarmList)
        }
        
    }
    
    func selectAlarmIndex(index:Int) {
        if let block = self.selectDateCallBack {
            if selectedAlarmIndexs.count == 2 {
                block(SELECTALARM_RESULT.SELECTED_ALARM_OVERSELECTED.rawValue,nil)
            }else {
                if selectedAlarmIndexs.contains(index) { selectedAlarmIndexs.remove(at: selectedAlarmIndexs.firstIndex(of: index)!)
                    block(SELECTALARM_RESULT.DISABLE_ALARMINDEX.rawValue,index)
                }else {
                    selectedAlarmIndexs.append(index)
                    block(SELECTALARM_RESULT.SELECTE_ALARMINDEX.rawValue,index)
                }
                
                for alarm in selectedAlarmIndexs {
                    selectedAlarm = (selectedAlarm != "" ? ",": selectedAlarm) + alarmList[alarm]
                }
                block(SELECTALARM_RESULT.SELECTED_ALARMTITLE_UPDATE.rawValue,selectedAlarm)
            }
        }
    }
    
    func checkSelectedAlarm() {
        if let block = self.selectDateCallBack {
            selectedAlarmIndexs.count == 0 ? block(SELECTALARM_RESULT.SELECTED_FAILE.rawValue,nil):block(SELECTALARM_RESULT.SELECTED_SUCCESS.rawValue,selectedAlarm)
        }
        
    }
}
