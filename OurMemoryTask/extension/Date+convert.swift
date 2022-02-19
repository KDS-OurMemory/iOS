//
//  Date+convert.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import Foundation


extension Date {
    func dateToStrFormat(formatStr:String) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatStr
        
        return dateFormatter.string(from: self)
    }
}
