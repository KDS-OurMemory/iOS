//
//  NSObject+className.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/21.
//

import Foundation

extension NSObject {
    static func className() -> String {
        return String(describing: self)
    }
}
