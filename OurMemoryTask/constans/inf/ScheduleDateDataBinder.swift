//
//  ScheduleDataBinder.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/02.
//

import Foundation
import UIKit

public protocol ScheduleDateDataBinder {
    func getScheduleColor() -> UIColor?
    func getName() -> String
}
