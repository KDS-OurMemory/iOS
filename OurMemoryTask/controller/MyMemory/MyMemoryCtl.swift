//
//  MyMemoryCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit



class MyMemoryCtl: BaseCollectionCtl {
    
    let myMemoryModel:MyMemoryModel = MyMemoryModel()
    let dateModel:DateComponentsModel = DateComponentsModel()
    
    override func __initWithData__(data: Any?) {
        
        self.myMemoryModel.initWithMyMemoryModelBlock { p1, p2 in
            switch p1 {
            case.UPDATEYEARMONTH:
                self.callUpdateYearMonth(yearMonth: p2 as! (String,String))
                break
            case .CHANGE:
                if let setAdapter = self.adapter {
                    setAdapter.changeData(section: 0, data: p2 as! [CalDateData])
                }
                break
            case .UPDATEIDX:
                if let setAdapter = self.adapter {
                    setAdapter.reloadCollectionViewAtRow(row: p2 as! Int, atSection: 0)
                }
                break
            case .UPDATEIDXS:
                if let setAdapter = self.adapter {
                    setAdapter.reloadCollectionViewAtRows(rows: p2 as! [Int], atSection: 0)
                }
                break
            }
            
        }
        
        self.dateModel.initWithCallback { p1, p2 in
            switch p1 {
            case .SELECTDATE:
                self.myMemoryModel.setCalenderData(year: "\(self.dateModel.getYear()!)", month: "\(self.dateModel.getMonth()!)", selectDates: p2 as! [CalDateData])
                break
            }
        }
        
        self.myMemoryModel.tryInqueryScheduleRequest(context: self)
    }
    
    fileprivate func callUpdateYearMonth(yearMonth:(String,String)) {
        if let view = self.view as? MyMemoryView {
            view.updateYearMonth(yearMonth: yearMonth)
        }
    }
}


extension MyMemoryCtl:MyMemoryContract {
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.setData(section: 0, data: self.dateModel.getCalendarDate())
            
            setAdapter.setOnOffBtnBlock { p1, p2 in
                if p1 {
                    self.myMemoryModel.selectIndex(index: p2.row)
                }
            }
        }
    }
    
    func actionCalPlusBtn(sender:UIButton) {
        
    }
    
    func actionCalMinusBtn(sender:UIButton) {
        
    }
    
    func actionAddSchduleBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTVIEW_ADDSCHEDULE, data: nil)
        }
    }
    
    func actionSelectSharedBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTViEW_SHAREDLIST, data: nil)
        }
    }
}
