//
//  SelectAlramView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol SelectAlramView:ViewContract {
    func updateAlarmList(alarmList:[String])
    func updateSelectedAlarmTitle(title:String)
    func applySelectedAlarms(alarms:String)
    func enableSelectedAlarmIndex(idx:Int)
    func disableSelectedAlarmIndex(idx:Int)
}
