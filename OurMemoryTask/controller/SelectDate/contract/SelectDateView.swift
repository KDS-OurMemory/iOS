//
//  SelectDateView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation

public protocol SelectDateView:ViewContract {
    func updateSelectedDates(dates:[String])
    func updateSelectedDateTitle(title:String)
}
