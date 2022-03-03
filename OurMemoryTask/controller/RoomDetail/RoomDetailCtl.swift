//
//  RoomDetailCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class RoomDetailCtl:BaseCollectionCtl
{
    let roomDetailModel:RoomDetailModel = RoomDetailModel()
    
    override func __initWithData__(data: Any?) {
        self.roomDetailModel.initRoomDetailDataWithBlock(data: data) { p1, p2 in
            switch p1 {
            case .UPDATEDATA:
                break
            default:
                break
            }
        }
    }
    
    fileprivate func callUpdateRoomData(data:RoomDataBinder) {
        if let view = self.view as? RoomDetailView {
            view.updateRoomData(data: data)
        }
    }
    
//    func getYear() -> Int? {
//        return self.roomDetailModel.getYear()
//    }
//
//    func getMonth() -> Int? {
//        return self.roomDetailModel.getMonth()
//    }
//
//
//    func getToday() -> Int? {
//        return self.roomDetailModel.getToday()
//    }
//
//    func getWeekToDay() -> Int? {
//        return self.roomDetailModel.getCurrentWeek()
//    }
//
//    func setMonth(month:Int) {
//        self.roomDetailModel.setMonth(month: month)
//    }
//
//    func setDay(day:Int) {
//        self.roomDetailModel.setDay(day: day)
//    }
//
//    func getCalendarDate() -> [calCellData] {
//        return self.roomDetailModel.getCalendarDate()
//    }
//
//    func getCalendarCnt() -> Int {
//        return self.roomDetailModel.getCalendarDateCnt()
//    }
//
//    func getWeekCntofMonth() -> Int {
//        return self.roomDetailModel.getWeekCntofMonth()
//    }
}

extension RoomDetailCtl:RoomDetailContract {
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
    }
    
    
}
