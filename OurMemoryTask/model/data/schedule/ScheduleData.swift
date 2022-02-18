//
//  scheduleData.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/09.
//

import UIKit

class ScheduleData: BaseObject {

    var title:String = ""
    var date:[ScheduleTimeDataBinder] = []
    var contents:[String] = []
    var locations:[String] = []
    var alarms:[String] = []
    var color:UIColor = .clear
    
    override func initData() {
        
    }
}
