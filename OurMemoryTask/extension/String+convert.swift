//
//  String+convert.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/04.
//

import Foundation
import UIKit

extension String {
    
    func stringToDateComponentWtihDateFormat(dateformatStr:String) -> DateComponents? {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateformatStr
        
        var calComponentSet:Set<Calendar.Component> = []
        if dateformatStr.contains("Y")||dateformatStr.contains("y") {
            calComponentSet.insert(.year)
        }
        if dateformatStr.contains("M"){
            calComponentSet.insert(.month)
        }
        if dateformatStr.contains("D")||dateformatStr.contains("d"){
            calComponentSet.insert(.day)
            calComponentSet.insert(.weekday)
        }
        if dateformatStr.contains("H"){
            calComponentSet.insert(.hour)
        }
        if dateformatStr.contains("m"){
            calComponentSet.insert(.minute)
        }
        if dateformatStr.contains("s"){
            calComponentSet.insert(.second)
        }
        if let date = dateformatter.date(from: self) {
            dateComponents = cal.dateComponents(calComponentSet, from: date)
            return dateComponents
        }
        return nil
    }
    
    func urlStringToImage(block:@escaping (UIImage?)->Void) {
        if let url = URL(string: self) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    block(UIImage(data: data!))
                }
            }
        }
    }
    
    func rgbToUIColor() -> UIColor? {
        var colorComponents:[Int16] = []
        var resultColor:UIColor?
        if self.count != 8 {
            print("유효하지않은 Hex값 입니다.")
            return nil
        }else {
            for component in self {
                colorComponents.append(Int16(component.wholeNumberValue!))
            }
            guard let red = Int16("\(colorComponents[0])\(colorComponents[1])") else {
                print("red값이 유효하지 않습니다.")
                return nil
            }
            guard let green = Int16("\(colorComponents[2])\(colorComponents[3])") else {
                print("blue값이 유효하지 않습니다.")
                return nil
            }
            guard let blue = Int16("\(colorComponents[4])\(colorComponents[5])") else {
                print("green값이 유효하지 않습니다.")
                return nil
            }
            if red >= 0,red <= 255,green >= 0,green <= 255,blue >= 0, blue <= 255 {
                resultColor = .init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
            }
            
        }
        
        return resultColor
    }
    
    func getYearStringWithDateFormatStr(dateFormatStr:String) -> String? {
        guard let startIdx = dateFormatStr.firstIndex(of: "y") else { return nil }
        guard let endIdx = dateFormatStr.lastIndex(of: "y") else { return nil }
        let result = self[startIdx...endIdx]
        return String(result)
    }
    
    func getMonthStringWithDateFormatStr(dateFormatStr:String) -> String? {
        guard let startIdx = dateFormatStr.firstIndex(of: "M") else { return nil }
        guard let endIdx = dateFormatStr.lastIndex(of: "M") else { return nil }
        let result = self[startIdx...endIdx]
        return String(result)
    }
    
    func getDayStringWithDateFormatStr(dateFormatStr:String) -> String? {
        guard let startIdx = dateFormatStr.firstIndex(of: "d") else { return nil }
        guard let endIdx = dateFormatStr.lastIndex(of: "d") else { return nil }
        let result = self[startIdx...endIdx]
        return String(result)
    }
    
    func getHourStringWithDateFormatStr(dateFormatStr:String) -> String? {
        guard let startIdx = dateFormatStr.firstIndex(of: "H") else { return nil }
        guard let endIdx = dateFormatStr.lastIndex(of: "H") else { return nil }
        let result = self[startIdx...endIdx]
        return String(result)
    }
    
    func getMinitStringWithDateFormatStr(dateFormatStr:String) -> String? {
        guard let startIdx = dateFormatStr.firstIndex(of: "m") else { return nil }
        guard let endIdx = dateFormatStr.lastIndex(of: "m") else { return nil }
        let result = self[startIdx...endIdx]
        return String(result)
    }
}
