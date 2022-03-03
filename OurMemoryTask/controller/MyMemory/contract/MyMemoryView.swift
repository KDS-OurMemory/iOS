//
//  myMemoryView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation

public protocol MyMemoryView:TabbarContract {
    func updateYearMonth(yearMonth:(String,String))
}
