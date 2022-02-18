//
//  SelectDateView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol SelectDateView:PopupContract {
    func updateSelectedSchedules(schedules:[ScheduleTimeDataBinder])
    func updateSelectedDateConfirmBtnState(state:Bool)
    func updateSelectedSchedulesData(selecteSchedule:ScheduleTimeDataBinder)
}
