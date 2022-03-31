//
//  SelectCalCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

class SelectCalCtl: BaseCollectionCtl {

    let selectCalModel:SelectCalModel = SelectCalModel()
    let dateModel:DateComponentsModel = DateComponentsModel()
    
    override func __initWithData__(data: Any?) {
        
        self.selectCalModel.initWithMyMemoryModelBlock { p1, p2 in
            switch p1 {
            case .UPDATESELECTINFO:
                self.callUpdateSelectDayInfo(data: p2 as! CalDateData)
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
                self.selectCalModel.setCalenderData(year: "\(self.dateModel.getYear()!)", month: "\(self.dateModel.getMonth()!)", selectDates: p2 as! [CalDateData])
                
                break
            }
        }
    }
    
    fileprivate func callUpdateSelectDayInfo(data:CalDateData) {
        if let view = self.view as? SelectCalView {
            view.updateSelectDateData(data: data)
//            let lunarDate = data.getSelectDateString().dateConvertLunarComponents(dateFormatStr: "yyyy-MM-dd HH:mm")
//            view.updateSelectDayLunar(lunar: "음력 \(lunarDate.month!).\(lunarDate.day!)")
        }
    }
    
    override func callShowNextVC(view: NEXTVIEW, data: Any?) {
        switch view {
        case .NEXTVIEW_POP:
            if let view = self.view as? SelectCalView {
                view.showNextVC(vc: .NEXTVIEW_POP, data: data)
            }
            break
        default:
            break
        }
    }
    
}

extension SelectCalCtl: SelectCalContract {
    
    func setCollectionWithAdpater(adapter: BaseCollectionAdapter) {
        self.adapter = adapter
        if let setAdapter = self.adapter {
            setAdapter.setData(section: 0, data: self.dateModel.getCalendarDate())
            
            setAdapter.setOnOffBtnBlock { p1, p2 in
                if p1 {
                    self.selectCalModel.selectIndex(index: p2.row)
                }
            }
        }
    }
    
    func actionCalPlusBtn() {
        self.dateModel.changeNextDate()
    }
    
    func actionCalMinusBtn() {
        self.dateModel.changePrevDate()
    }
    
    func actionCancelBtn() {
        
    }
    
    func actionConfirmBtn() {
        
    }
}
