//
//  AddScheduleContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol AddScheduleContract:DataContract {
    
    func setScheduleTitle(title:String)
    func addDate(date:ScheduleTimeDataBinder)
    func addContent(content:String)
    func addLocation(location:String)
    func setAlarm(alarm:String)
    func setColor(color:UIColor)
    
    func actionDatesView()
    func actionAlarmsView()
    func actionContentsView()
    func actionLocationsView()
    func actionColorView()
    func actionSharedView()
    func actionConfirmBtn(sender:UIButton)
    func actionCloseBtn(sender:UIButton)
}
