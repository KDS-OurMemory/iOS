//
//  Sting+UIColor.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/02.
//

import Foundation
import UIKit

extension String {
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
}
