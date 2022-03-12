//
//  AddScheduleModel.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/09.
//

import UIKit

enum SCHEDULERESULT {
    case SCHEDULE_UPDATE
    case SCHEDULEALARMTIME_UPDATE
    case SCHEDULECOLOR_UPDATE
    case SCHEDULE_UPDATE_SELECTED_DATE
    case SCHEDULECONFIRMBTN_UPDATE
}

class AddScheduleModel: NSObject {
    
    var scheduleData:ScheduleData = ScheduleData()
    
    var scheduleBlock:((SCHEDULERESULT,Any?) -> Void)?
    var alrams:[String] = []
    var selectedDateComponents:[DateComponents] = []
    var selectedDateComponent:DateComponents = DateComponents()
    var addScheduleParams:[String:Any] = [:]
    var addScheduleInputDataCheck:ADDSCHEDULE_INPUTDATA_CHECK = []
    let addScheduleNetModel:AddScheduleNetModel = AddScheduleNetModel()
    var endDate:DateComponents?
    var startDate:DateComponents?
    var sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    var firstAlarm:Date?
    var secondsAlarm:Date?
    
    func initWithBlock(data:Any?, block:@escaping (SCHEDULERESULT,Any)->Void) {
        
        if let scheduleData = data as? scheduleData {
            
            self.setTitle(title: scheduleData.name)
            if let startDatecomponents = scheduleData.startDate.stringToDateComponentWtihDateFormat(dateformatStr: "yyyy-MM-dd HH:mm") {
                self.addDate(date: ScheduleTimeData(year: "\(startDatecomponents.year!)", month: "\(startDatecomponents.month!)", day: "\(startDatecomponents.day!)", our: "\(startDatecomponents.hour!)", min: "\(startDatecomponents.minute!)", weekDay: "\(startDatecomponents.weekday!)", components: startDatecomponents))
            }
            if let endDatecomponents = scheduleData.endDate.stringToDateComponentWtihDateFormat(dateformatStr: "yyyy-MM-dd HH:mm") {
                self.addDate(date: ScheduleTimeData(year: "\(endDatecomponents.year!)", month: "\(endDatecomponents.month!)", day: "\(endDatecomponents.day!)", our: "\(endDatecomponents.hour!)", min: "\(endDatecomponents.minute!)", weekDay: "\(endDatecomponents.weekday!)", components: endDatecomponents))
            }
            
            
        }
        scheduleBlock = block
        if let scheduleBlock = scheduleBlock {
            scheduleBlock(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func setTitle(title:String) {
        if title.count > 0 {
            scheduleData.title = title
            addScheduleInputDataCheck.insert(.ADDSCHEDULE_INPUT_TITLE)
            self.valideCheckAddSchedulData()
        }else {
            addScheduleInputDataCheck.remove(.ADDSCHEDULE_INPUT_TITLE)
        }
        
    }
    
    func addDate(date:ScheduleTimeDataBinder) {
        scheduleData.date.append(date)
        addScheduleInputDataCheck.insert(.ADDSCHEDULE_INPUT_DATE)
        self.valideCheckAddSchedulData()
        if let component = date.getComponents() {
            selectedDateComponent = component
            if startDate == nil {
                startDate = component
                addScheduleParams["startDate"] = component.dateComponentsToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
            }else {
                switch startDate?.comparison(targetDateComponents: component) {
                case .orderedAscending:
                    startDate = component
                    addScheduleParams["startDate"] =  component.dateComponentsToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
                    break
                default:
                    break
                }
            }
            
            if endDate == nil {
                endDate = component
                addScheduleParams["endDate"] = component.dateComponentsToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
            }else {
                switch endDate?.comparison(targetDateComponents: component) {
                case .orderedDescending:
                    endDate = component
                    addScheduleParams["endDate"] = component.dateComponentsToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
                    break
                default:
                    break
                }
            }
            
            if selectedDateComponents.contains(component) == false {
                selectedDateComponents.append(component)
                scheduleData.alarms.removeAll()
                firstAlarm = nil
                secondsAlarm = nil
                for alram in alrams {
                    self.getTimeIntervalDateForAlarm(alarm: alram)
                }
            }
        }
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func addContent(content:String) {
        scheduleData.contents.append(content)
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func addLocation(location:String) {
        scheduleData.locations.append(location)
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE,scheduleData)
        }
    }
    
    func setAlarm(alarm:String) {
        if alarm.contains(",") {
            self.alrams = alarm.components(separatedBy: ",")
        } else if self.alrams.contains(alarm) != false {
            self.alrams.append(alarm)
        }
        self.getTimeIntervalDateForAlarm(alarm: alarm)
        if let block = self.scheduleBlock {
            block(.SCHEDULEALARMTIME_UPDATE,alarm)
        }
    }
    
    func setColor(color:UIColor) {
        scheduleData.color = color
        if let block = self.scheduleBlock {
            block(.SCHEDULECOLOR_UPDATE,color)
        }
        
    }
    
    func getSelectedDate() {
        if let block = self.scheduleBlock {
            block(.SCHEDULE_UPDATE_SELECTED_DATE,scheduleData)
        }
    }
    
    func getTimeIntervalDateForAlarm(alarm:String) {
        if var date = Calendar.current.date(from: selectedDateComponent) {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
            switch alarm {
            case "정시":
                break
            case "5분 전":
                date = date - 300
                break
            case "10분 전":
                date = date - 600
                break
            case "15분 전":
                date = date - 900
                break
            case "30분 전":
                date = date - 1800
                break
            case "1시간 전":
                date = date - 3600
                break
            case "2시간 전":
                date = date - 7200
                break
            case "3시간 전":
                date = date - 10800
                break
            case "12시간 전":
                date = date - 43200
                break
            case "1일 전":
                date = date - 86400
                break
            case "2일 전":
                date = date - 172800
                break
            default:
                break
            }
            if firstAlarm == nil {
                firstAlarm = date
            }else {
                switch firstAlarm!.compare(date) {
                case .orderedAscending:
                    firstAlarm = date
                    break
                default:
                    break
                }
            }
            if alrams.count > 1 {
                if secondsAlarm == nil {
                    secondsAlarm = date
                }else {
                    switch secondsAlarm!.compare(date) {
                    case.orderedDescending:
                        secondsAlarm = date
                        break
                    default:
                        break
                    }
                }
            }
            
            
            let dateStr = dateformatter.string(from: date)
            if scheduleData.alarms.contains(dateStr) {
                return
            }else {
                scheduleData.alarms.append(dateStr)
                addScheduleInputDataCheck.insert(.ADDSCHEDULE_INPUT_ALARM)
                self.valideCheckAddSchedulData()
            }
        }
    }
    
    func valideCheckAddSchedulData() {
        if let block = self.scheduleBlock {
            if addScheduleInputDataCheck.contains([.ADDSCHEDULE_INPUT_TITLE,.ADDSCHEDULE_INPUT_DATE]) {
                
                block(.SCHEDULECONFIRMBTN_UPDATE,true)
                
            }else {
                block(.SCHEDULECONFIRMBTN_UPDATE,false)
            }
        }
    }
    
    func hexStringFromColor(color: UIColor) -> String {
        let hexString = ""
        if let components = color.cgColor.components,components.count > 2 {
            let r: CGFloat = components[0]
            let g: CGFloat = components[1]
            let b: CGFloat = components[2]
        
        

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        
        }
        return hexString
     }
    
    func tryAddScheduleRequest(context:DataContract) {
        
        addScheduleParams["attendanceStatus"] = ATTENDANCE_STATUS.ABSENCE.rawValue
        addScheduleParams["bgColor"] = self.hexStringFromColor(color:scheduleData.color)
        addScheduleParams["name"] = scheduleData.title
        addScheduleParams["userId"] = "\(sharedUserDataModel.userData.userId)"
//        addScheduleParams["place"] = scheduleData.locations
//        addScheduleParams["shareIds"] = nil
//        addScheduleParams["contents"] = scheduleData.contents.description
        if let firstAlarm = firstAlarm {
            addScheduleParams["firstAlarm"] = firstAlarm.dateToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
        }
        if let secondsAlarm = secondsAlarm {
            addScheduleParams["secondAlarm"] = secondsAlarm.dateToStrFormat(formatStr:"yyyy-MM-dd HH:mm")
        }
        
        
        addScheduleNetModel.setRequestBodyParams(params: addScheduleParams)
        
        self.addScheduleNetModel.reqeustRestFulApi(context: context) {(data: Result<json<scheduleData>,Error >) in
            switch data {
            case .success(let responseData):
                if let response = responseData.response {
                    
                }
                break
            default:
                break
            }
        }
    }
}
