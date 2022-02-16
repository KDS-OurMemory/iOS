//
//  RoomDetailCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class RoomDetailCtl:BaseCtl
{
    let roomDetailModel:DateComponentsModel = DateComponentsModel()
    
    func onViewDidLoad() {
//        if let view = self.view
//        {
//            if let year = self.getYear(), let month = self.getMonth()
//            {
//                view.updateYearAndMonth(year: year, month: month)
//            }
//            view.setUpDefine()
//            view.setUpLayout()
//
//        }
//
    }
    
//    func configure(cell:roomDetailCalCell,date:calCellData) {
//        cell.setDate(date: date)
//    }
//
//    func changeState(cell:roomDetailCalCell,data:calCellData,state:ROOMDETAILSCROLLPOINT){
//        cell.changeStateCell(data: data, state: state)
//    }
    
    func getYear() -> Int? {
        return self.roomDetailModel.getYear()
    }
    
    func getMonth() -> Int? {
        return self.roomDetailModel.getMonth()
    }
    
    
    func getToday() -> Int? {
        return self.roomDetailModel.getToday()
    }
    
    func getWeekToDay() -> Int? {
        return self.roomDetailModel.getCurrentWeek()
    }
    
    func setMonth(month:Int) {
        self.roomDetailModel.setMonth(month: month)
    }
    
    func setDay(day:Int) {
        self.roomDetailModel.setDay(day: day)
    }
    
    func getCalendarDate() -> [calCellData] {
        return self.roomDetailModel.getCalendarDate()
    }
    
    func getCalendarCnt() -> Int {
        return self.roomDetailModel.getCalendarDateCnt()
    }
   
    func getWeekCntofMonth() -> Int {
        return self.roomDetailModel.getWeekCntofMonth()
    }
}
