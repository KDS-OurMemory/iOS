//
//  Date+comparison.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/19.
//

import Foundation

extension DateComponents {
    func comparison(targetDateComponents:DateComponents) -> ComparisonResult? {
        if let selfDate = Calendar.current.date(from: self), let targetDate = Calendar.current.date(from: targetDateComponents) {
            return selfDate.compare(targetDate)
        }
        
        return nil
        
    }
}
