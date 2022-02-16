//
//  BaseDatePickerCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/20.
//

import Foundation
import UIKit

open class BaseDatePickerAdapter:NSObject,UIPickerViewDelegate,UIPickerViewDataSource{
    
    private(set) var pickerView:UIPickerView?
    private(set) var mode:PICKER_MODE = .UNOWNED
    private(set) var data:[COMPONENT_TYPE:Set<UInt>] = [:]
    private(set) var selectedRow:[COMPONENT_TYPE:Int] = [:]
    private(set) var callback:UINTANY_VOID?
    let dateModel:DateComponentsModel = DateComponentsModel()
    
    func setPickerController(pickerView:UIPickerView,pickerViewMode:PICKER_MODE, callback:@escaping UINTANY_VOID) {
        if let picker = self.pickerView {
            picker.delegate = self
            picker.dataSource = self
            self.pickerView = picker
            self.mode = pickerViewMode
            self.callback = callback
        }
    }
    
    func getSelectedDate() {
        
        if let years = data[COMPONENT_TYPE.YEAR]?.sorted(),let selectedYearIndex = selectedRow[COMPONENT_TYPE.YEAR] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_YEAR.rawValue,years[selectedYearIndex])
            }
            
        }
        
        if let months = data[COMPONENT_TYPE.MONTH]?.sorted(),let selectedMonthIndex = selectedRow[COMPONENT_TYPE.MONTH] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_MONTH.rawValue,months[selectedMonthIndex])
            }
        }
        
        if let days = data[COMPONENT_TYPE.DAY]?.sorted(),let selectedDayIndex = selectedRow[COMPONENT_TYPE.DAY] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_MONTH.rawValue,days[selectedDayIndex])
            }
        }
        
        if let times = data[COMPONENT_TYPE.TIME]?.sorted(),let selectedTimeIndex = selectedRow[COMPONENT_TYPE.TIME] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_TIME.rawValue,times[selectedTimeIndex])
            }
        }
        
        if let minutes = data[COMPONENT_TYPE.MINUTE]?.sorted(),let selectedMinuteIndex = selectedRow[COMPONENT_TYPE.MINUTE] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_MINUTE.rawValue,minutes[selectedMinuteIndex])
            }
        }
        
        if let seconds = data[COMPONENT_TYPE.SECONDS]?.sorted(),let selectedSecondsIndex = selectedRow[COMPONENT_TYPE.MINUTE] {
            if let callback = self.callback {
                callback(RESULT_DATE.RESULT_SECONDS.rawValue,seconds[selectedSecondsIndex])
            }
        }
    }
    
    func selectComponentofRow(selectToComponent:COMPONENT_TYPE,row:Int) {
        var component:Int = 0
        
        switch selectToComponent {
        case .YEAR:
            break
        case .MONTH:
            switch self.mode {
            case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD,.YY_MM:
                component = 1
                break
            default:
                break
            }
            break
        case .DAY:
            switch self.mode {
            case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD:
                component = 2
                break
            case .MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD:
                component = 1
                break
            default:
                break
            }
            break
        case .TIME:
            switch self.mode {
            case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD:
                component = 3
                break
            case .MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD:
                component = 2
                break
            case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt:
                component = 1
                break
            default:
                break
            }
            break
        case .MINUTE:
            switch self.mode {
            case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD:
                component = 4
                break
            case .MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD:
                component = 3
                break
            case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt:
                component = 2
                break
            case .tt_mm_ss,.tt_mm:
                component = 1
                break
            default:
                break
            }
            break
        case .SECONDS:
            switch self.mode {
            case .YY_MM_DD_tt_mm_ss:
                component = 5
                break
            case .MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD:
                component = 4
                break
            case .DD_tt_mm_ss:
                component = 3
                break
            case .tt_mm_ss:
                component = 2
                break
            case .mm_ss:
                component = 1
                break
            default:
                break
            }
            break
        }
        
        pickerView?.selectRow(row, inComponent: component, animated: true)
    }
    
    fileprivate func getNumberOfComponent() -> Int {
        var componentCnt = 0
        switch self.mode {
        case .YY_MM_DD_tt_mm_ss:
            componentCnt = 6
            break
        case .YY_MM_DD_tt_mm,.MM_DD_tt_mm_ss:
            componentCnt = 5
            break
        case .YY_MM_DD_tt,.MM_DD_tt_mm,.DD_tt_mm_ss:
            componentCnt = 4
            break
        case .YY_MM_DD,.MM_DD_tt,.DD_tt_mm,.tt_mm_ss:
            componentCnt = 3
            break
        case .YY_MM,.MM_DD,.DD_tt,.tt_mm,.mm_ss:
            componentCnt = 2
            break
        case .YY,.MM,.DD,.tt,.mm,.ss:
            componentCnt = 1
            break
        case .UNOWNED:
            break
        }
        
        return componentCnt
    }
    
    fileprivate func getTitleOfRowsInComponent(component:Int, numberOfRow:Int) -> String {
        var titleOfRowInComponent = ""
        switch self.mode {
        case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD,.YY_MM,.YY:
            switch component {
            case 0:
                if let year  = self.getYearTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(year)"
                    data[COMPONENT_TYPE.YEAR]?.insert(year)
                }
                break
            case 1:
                if let month =  self.getMonthTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(month)"
                    data[COMPONENT_TYPE.MONTH]?.insert(month)
                }
                break
            case 2:
                if let day = self.getDayTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(day)"
                    data[COMPONENT_TYPE.DAY]?.insert(day)
                }
                break
            case 3:
                if let time = self.getTimeTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(time)"
                    data[COMPONENT_TYPE.TIME]?.insert(time)
                }
                break
            case 4,5:
                if let mmss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(mmss)"
                    data[COMPONENT_TYPE.MINUTE]?.insert(mmss)
                    data[COMPONENT_TYPE.SECONDS]?.insert(mmss)
                }
                break
            default:
                break
            }
            
            break
        case.MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD,.MM:
            switch component {
            case 0:
                if let month = self.getMonthTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(month)"
                    data[COMPONENT_TYPE.MONTH]?.insert(month)
                }
                break
            case 1:
                if let day = self.getDayTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(day)"
                    data[COMPONENT_TYPE.DAY]?.insert(day)
                }
                break
            case 2:
                if let time = self.getTimeTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(time)"
                    data[COMPONENT_TYPE.TIME]?.insert(time)
                }
                break
            case 3:
                if let mm = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(mm)"
                    data[COMPONENT_TYPE.MINUTE]?.insert(mm)
                    
                }
                break
            case 4:
                if let ss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(ss)"
                    data[COMPONENT_TYPE.SECONDS]?.insert(ss)
                }
                break
            default:
                break
            }
            break
        case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt,.DD:
            switch component {
            case 0:
                if let day = self.getDayTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(day)"
                    data[COMPONENT_TYPE.DAY]?.insert(day)
                }
                break
            case 1:
                if let time = self.getTimeTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(time)"
                    data[COMPONENT_TYPE.TIME]?.insert(time)
                }
                break
            case 2:
                if let mmss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(mmss)"
                    data[COMPONENT_TYPE.MINUTE]?.insert(mmss)
                    data[COMPONENT_TYPE.SECONDS]?.insert(mmss)
                }
                break
            default:
                break
            }
            break
        case .tt_mm_ss,.tt_mm,.tt:
            switch component {
            case 0:
                if let time = self.getTimeTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(time)"
                    data[COMPONENT_TYPE.TIME]?.insert(time)
                }
                break
            case 1:
                if let mm = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(mm)"
                    data[COMPONENT_TYPE.MINUTE]?.insert(mm)
                }
                break
            case 2:
                if let ss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(ss)"
                    data[COMPONENT_TYPE.SECONDS]?.insert(ss)
                }
            default:
                break
            }
            break
        case .mm_ss,.mm:
            switch component {
            case 0,1:
                if let mmss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(mmss)"
                    data[COMPONENT_TYPE.MINUTE]?.insert(mmss)
                    data[COMPONENT_TYPE.SECONDS]?.insert(mmss)
                }
                break
            default:
                break
            }
            break
        case .ss:
            switch component {
            case 0:
                if let ss = self.getMMSSTitle(row: numberOfRow) {
                    titleOfRowInComponent = "\(ss)"
                    data[COMPONENT_TYPE.SECONDS]?.insert(ss)
                }
                break
            default:
                break
            }
            break
        case .UNOWNED:
            break
        }
        return titleOfRowInComponent
    }
    
    fileprivate func getNumberOfRowsInComponent(component:Int) -> Int {
        var limitOfRowInComponent = 0
        switch self.mode {
        case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD,.YY_MM,.YY:
            switch component {
            case 0:
                limitOfRowInComponent = self.getLimitOfYear()
                break
            case 1:
                limitOfRowInComponent = self.getLimitOfMonth()
                break
            case 2:
                limitOfRowInComponent = self.getLimitOfDay()
                break
            case 3:
                limitOfRowInComponent = self.getLimitOfTime()
                break
            case 4,5:
                limitOfRowInComponent = self.getLimitOfMMSS()
                break
            default:
                break
            }
            
            break
        case.MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD,.MM:
            switch component {
            case 0:
                limitOfRowInComponent = self.getLimitOfMonth()
                break
            case 1:
                limitOfRowInComponent = self.getLimitOfDay()
                break
            case 2:
                limitOfRowInComponent = self.getLimitOfTime()
                break
            case 3,4:
                limitOfRowInComponent = self.getLimitOfMMSS()
                break
            default:
                break
            }
            break
        case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt,.DD:
            switch component {
            case 0:
                limitOfRowInComponent = self.getLimitOfDay()
                break
            case 1:
                limitOfRowInComponent = self.getLimitOfTime()
                break
            case 2:
                limitOfRowInComponent = self.getLimitOfMMSS()
                break
            default:
                break
            }
            break
        case .tt_mm_ss,.tt_mm,.tt:
            switch component {
            case 0:
                limitOfRowInComponent = self.getLimitOfTime()
                break
            case 1,2:
                limitOfRowInComponent = self.getLimitOfMMSS()
                break
            default:
                break
            }
            break
        case .mm_ss,.mm,.ss:
            switch component {
            case 0,1:
                limitOfRowInComponent = self.getLimitOfMMSS()
                break
            default:
                break
            }
            break
        case .UNOWNED:
            break
        }
        return limitOfRowInComponent
    }
    
    fileprivate func reloadRow(pickerView:UIPickerView,component:Int) {
        for componentType in (component+1)...pickerView.numberOfComponents {
            pickerView.reloadComponent(componentType)
        }
    }
    
    fileprivate func reloadRowOfComponent(pickerView:UIPickerView ,component:Int) {
        switch self.mode {
        case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD,.YY_MM,.YY:
            switch component {
            case 0:
                self.reloadRow(pickerView: pickerView, component: component)
                data[COMPONENT_TYPE.DAY]?.removeAll()
                selectedRow[COMPONENT_TYPE.DAY] = 0
                break
            case 1:
                self.reloadRow(pickerView: pickerView, component: component)
                data[COMPONENT_TYPE.DAY]?.removeAll()
                selectedRow[COMPONENT_TYPE.DAY] = 0
                break
            case 2:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 3:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 4:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 5:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            default:
                break
            }
            break
        case.MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD,.MM:
            switch component {
            case 0:
                self.reloadRow(pickerView: pickerView, component: component)
                data[COMPONENT_TYPE.DAY]?.removeAll()
                selectedRow[COMPONENT_TYPE.DAY] = 0
                break
            case 1:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 2:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 3:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 4:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            default:
                break
            }
            break
        case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt,.DD:
            switch component {
            case 0:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 1:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 2:
                break
            default:
                break
            }
            break
        case .tt_mm_ss,.tt_mm,.tt:
            switch component {
            case 0:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            case 1:
                break
            default:
                break
            }
            break
        case .mm_ss,.mm,.ss:
            switch component {
            case 0,1:
                self.reloadRow(pickerView: pickerView, component: component)
                break
            default:
                break
            }
            break
        case .UNOWNED:
            break
        }
    }
    
    fileprivate func setSelectedRow(component:Int, row:Int) {
        switch self.mode {
        case .YY_MM_DD_tt_mm_ss,.YY_MM_DD_tt_mm,.YY_MM_DD_tt,.YY_MM_DD,.YY_MM,.YY:
            switch component {
            case 0:
                selectedRow[COMPONENT_TYPE.YEAR] = row
                break
            case 1:
                selectedRow[COMPONENT_TYPE.MONTH] = row
                break
            case 2:
                selectedRow[COMPONENT_TYPE.DAY] = row
                break
            case 3:
                selectedRow[COMPONENT_TYPE.TIME] = row
                break
            case 4:
                selectedRow[COMPONENT_TYPE.MINUTE] = row
                break
            case 5:
                selectedRow[COMPONENT_TYPE.SECONDS] = row
                break
            default:
                break
            }
            break
        case.MM_DD_tt_mm_ss,.MM_DD_tt_mm,.MM_DD_tt,.MM_DD,.MM:
            switch component {
            case 0:
                selectedRow[COMPONENT_TYPE.MONTH] = row
                break
            case 1:
                selectedRow[COMPONENT_TYPE.DAY] = row
                break
            case 2:
                selectedRow[COMPONENT_TYPE.TIME] = row
                break
            case 3:
                selectedRow[COMPONENT_TYPE.MINUTE] = row
                break
            case 4:
                selectedRow[COMPONENT_TYPE.SECONDS] = row
                break
            default:
                break
            }
            break
        case .DD_tt_mm_ss,.DD_tt_mm,.DD_tt,.DD:
            switch component {
            case 0:
                selectedRow[COMPONENT_TYPE.DAY] = row
                break
            case 1:
                selectedRow[COMPONENT_TYPE.TIME] = row
                break
            case 2:
                selectedRow[COMPONENT_TYPE.MINUTE] = row
                break
            case 3:
                selectedRow[COMPONENT_TYPE.SECONDS] = row
                break
            default:
                break
            }
            break
        case .tt_mm_ss,.tt_mm,.tt:
            switch component {
            case 0:
                selectedRow[COMPONENT_TYPE.TIME] = row
                break
            case 1:
                selectedRow[COMPONENT_TYPE.MINUTE] = row
                break
            case 2:
                selectedRow[COMPONENT_TYPE.SECONDS] = row
                break
            default:
                break
            }
            break
        case .mm_ss,.mm:
            switch component {
            case 0:
                selectedRow[COMPONENT_TYPE.MINUTE] = row
                break
            case 1:
                selectedRow[COMPONENT_TYPE.SECONDS] = row
                break
            default:
                break
            }
            break
        case .ss:
            selectedRow[COMPONENT_TYPE.SECONDS] = row
            break
        case .UNOWNED:
            break
        }
    }
    
    fileprivate func getYearTitle(row:Int) -> UInt? {
        if let year = self.dateModel.getCurrentYear() {
            return UInt(year-100 + row)
        }
        return nil
    }
    
    fileprivate func getMonthTitle(row:Int) -> UInt? {
        let month = 1+row
        if month > self.getLimitOfMonth() {
            return nil
        }
        return UInt(month)
    }
    
    fileprivate func getDayTitle(row:Int) -> UInt? {
        let day = 1+row
        if self.getLimitOfDay() > day {
            return nil
        }
        return UInt(day)
    }
    
    fileprivate func getTimeTitle(row:Int) -> UInt? {
        let time = 1+row
        if time > self.getLimitOfTime() {
            return nil
        }
        return UInt(time)
    }
    
    fileprivate func getMMSSTitle(row:Int) -> UInt? {
        let mmss = 1+row
        if mmss > getLimitOfMMSS() {
            return nil
        }
        return UInt(mmss)
    }
    
    fileprivate func getLimitOfYear() -> Int {
        return 100
    }
    
    fileprivate func getLimitOfMonth() -> Int {
        return 12
    }
    
    fileprivate func getLimitOfDay() -> Int {
        return self.dateModel.getDayofDate(date: self.dateModel.endOfMonth)
    }
    
    fileprivate func getLimitOfTime() -> Int {
        return 24
    }
    
    fileprivate func getLimitOfMMSS() -> Int {
        return 60
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.getNumberOfRowsInComponent(component: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.getTitleOfRowsInComponent(component: component, numberOfRow: row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setSelectedRow(component: component, row: row)
        self.reloadRowOfComponent(pickerView: pickerView, component: component)
        self.getSelectedDate()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.getNumberOfComponent()
    }
    
    
}
