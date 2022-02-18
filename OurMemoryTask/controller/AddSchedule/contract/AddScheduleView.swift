//
//  AddScheduleView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol AddScheduleView:ViewContract {
    func updateScheduleData(dataBinder:ScheduleDataBinder)
    
    func updaetConfirmBtnState(state:Bool)
    func updateAlarm(alarm:String)
    func updateColor(color:UIColor)
}
