//
//  RommDetailView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation

public protocol RoomDetailView:ViewContract {
    func updateRoomData(data:RoomDataBinder)
    func updateYearMonth(yearMonth:(String,String))
    func updateScheduleDatas(datas:[ScheduleDateDataBinder]?)
    func updateSelectDay(day:String)
    func updateSelectDayLunar(lunar:String)
    
}
