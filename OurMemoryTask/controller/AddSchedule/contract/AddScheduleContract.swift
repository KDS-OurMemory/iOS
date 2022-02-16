//
//  AddScheduleContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol AddScheduleContract:DataContract {
    func addDate(date:String)
    func addContent(content:String)
    func addLocation(location:String)
    func setAlarm(alarm:String)
    func setColor(color:UIColor)
    
    func actionDatesView(sender:UIView)
    func actionContentsView(sender:UIView)
    func actionLocationsView(sender:UIView)
    func actionColorView(sender:UIView)
    func actionSharedView(sender:UIView)
    func actionConfirmBtn(sender:UIButton)
    func actionCloseBtn(sender:UIButton)
}
