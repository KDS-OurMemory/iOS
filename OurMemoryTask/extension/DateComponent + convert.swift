//
//  DateComponent + convert.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import Foundation


extension DateComponents {
    func dateComponentsToStrFormat(formatStr:String) -> String {
        var resultStr = ""
        if let selfDate = Calendar.current.date(from: self) {
            let dateformat:DateFormatter = DateFormatter()
            dateformat.dateFormat = formatStr
            resultStr = dateformat.string(from: selfDate)
            return resultStr
        }
        return resultStr
    }
}
