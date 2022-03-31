//
//  SelectDateCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import UIKit

class SelectDateCtl: BaseCtl {

    
    var datePickerAdapter:BaseDatePickerAdapter!
    var selectDateModel:SelectDateModel = SelectDateModel()
    
    override func __initWithData__(data: Any?) {
        selectDateModel.initDataWithCallback(data: data) { p1, p2 in
            switch p1 {
            case .UPDATE_SELECTDATE:
                self.callSchedule(selecteSchedule: p2 as! ScheduleTimeDataBinder)
                self.callDismissPopup()
                break
            case .UPDATE_SELECTEDDATE:
                self.callSelectedSchedule(selectedSchedule: p2 as! [ScheduleTimeDataBinder])
                break
            case .VALIDECHECK_CONFIRMBTN:
                self.callUpdateConfirmBtnState(state: p2 as! Bool)
                break
            }
        }
    }
    
    fileprivate func callSchedule(selecteSchedule:ScheduleTimeDataBinder) {
        if let view = self.view as? SelectDateView {
            view.updateSelectedSchedulesData(selecteSchedule: selecteSchedule)
        }
    }
    
    fileprivate func callSelectedSchedule(selectedSchedule:[ScheduleTimeDataBinder]) {
        if let view = self.view as? SelectDateView {
            view.updateSelectedSchedules(schedules: selectedSchedule)
        }
    }
    
    fileprivate func callUpdateConfirmBtnState(state:Bool) {
        if let view = self.view as? SelectDateView {
            view.updateSelectedDateConfirmBtnState(state: state)
        }
    }
    
    fileprivate func callDismissPopup() {
        if let view = self.view as? SelectDateView {
            view.dismissPopup()
        }
    }
    
}

extension SelectDateCtl:SelectDateContract {
    
    func selectDateIdx(idx: Int) {
        
    }
    
    func actionConfirmBtn(sender: UIButton) {
        if let setAdapter = self.datePickerAdapter {
            setAdapter.getSelectedDate()
            selectDateModel.tryGetScheduleTimeData()
        }
        
    }
    
    func actionCancelBtn(sender: UIButton) {
        if let view = self.view as? SelectDateView {
            view.dismissPopup()
        }
    }
    
    func setDatePickerWithAdpater(adapter: BaseDatePickerAdapter,pickerView:UIPickerView) {
        datePickerAdapter = adapter
        self.datePickerAdapter.setPickerController(pickerView: pickerView, pickerViewMode:PICKER_MODE.YY_MM_DD_tt_mm) { p1,p2 in
            let result:RESULT_DATE = RESULT_DATE.init(rawValue: p1)!
            switch result {
            case .RESULT_YEAR:
                self.selectDateModel.setYear(year: p2 as! String)
                break
            case .RESULT_MONTH:
                self.selectDateModel.setMonth(month: p2 as! String)
                break
            case .RESULT_DAY:
                self.selectDateModel.setDay(day: p2 as! String)
                break
            case .RESULT_TIME:
                self.selectDateModel.setOur(our: p2 as! String)
                break
            case .RESULT_MINUTE:
                self.selectDateModel.setMin(min: p2 as! String)
                break
            case .RESULT_WEEKS:
                self.selectDateModel.setWeekDay(weekDay: p2 as! String)
                break
            case .RESULT_DATECOMPONENTS:
                self.selectDateModel.setDateComponents(datecomponents: p2 as! DateComponents)
                break
            default:
                break
            }
        }
        self.datePickerAdapter.selectMoveCurrentDate()
    }
}
