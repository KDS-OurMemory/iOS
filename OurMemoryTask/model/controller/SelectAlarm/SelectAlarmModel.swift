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
    case SELECTED_APPLYALARMLIST_UPDATE
    case SELECTE_ALARMINDEX
    case DISABLE_ALARMINDEX
    case DISMISS_POPUP
}

class SelectAlarmModel: NSObject {

    let alarmList:[String] = ["정시","5분 전","10분 전","15분 전","30분 전","1시간 전","2시간 전","3시간 전","12시간 전","1일 전","2일 전"]
    var selectedAlarmIndexs:[Int] = []
    var selectDateCallBack:UINTANY_VOID?
    var selectedAlarm = ""
    
    func initWithCallback(data:Any?,callBack:@escaping UINTANY_VOID) {
        
        
        selectDateCallBack = callBack
        if let block = self.selectDateCallBack {
            block(SELECTALARM_RESULT.SELECTED_ALARMLIST_UPDATE.rawValue,alarmList)
            if let data = data as? [String], data.count > 0 {
                selectedAlarmIndexs.removeAll()
                for selectedAlarm in data {
                    if let selectIndex = alarmList.firstIndex(of: selectedAlarm) {
                        self.selectAlarmIndex(index:  selectIndex)
                    }
                }
            }else {
                self.selectAlarmIndex(index: 0)
            }
            
        }
        
    }
    
    func selectAlarmIndex(index:Int) {
        if let block = self.selectDateCallBack {
            
            if selectedAlarmIndexs.contains(index) {
                selectedAlarmIndexs.remove(at: selectedAlarmIndexs.firstIndex(of: index)!)
                block(SELECTALARM_RESULT.DISABLE_ALARMINDEX.rawValue,index)
                if let range = selectedAlarm.range(of: alarmList[index]) {
                    selectedAlarm.removeSubrange(range)
                    if selectedAlarm.contains(",") {
                        selectedAlarm.remove(at: selectedAlarm.firstIndex(of: ",")!)
                    }
                    block(SELECTALARM_RESULT.SELECTED_ALARMTITLE_UPDATE.rawValue,selectedAlarm)
                    return
                }
            }else {
                if selectedAlarmIndexs.count == 2 {
                    block(SELECTALARM_RESULT.SELECTED_ALARM_OVERSELECTED.rawValue,nil)
                    block(SELECTALARM_RESULT.DISABLE_ALARMINDEX.rawValue,index)
                    return
                }
                selectedAlarmIndexs.append(index)
                block(SELECTALARM_RESULT.SELECTE_ALARMINDEX.rawValue,index)
            }
            
            selectedAlarm =  (selectedAlarm != "" ? "\(selectedAlarm),": "") + alarmList[index]
            
            block(SELECTALARM_RESULT.SELECTED_ALARMTITLE_UPDATE.rawValue,selectedAlarm)
            
        }
    }
    
    func tryGetApplyedAlarm() {
        if let block = self.selectDateCallBack {
            
            if self.selectedAlarm.count > 0 {
                block(SELECTALARM_RESULT.SELECTED_APPLYALARMLIST_UPDATE.rawValue,self.selectedAlarm)
                block(SELECTALARM_RESULT.DISMISS_POPUP.rawValue,nil)
            }
    
        }
    }
    

    
}
