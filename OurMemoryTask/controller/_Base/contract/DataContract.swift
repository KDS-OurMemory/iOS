//
//  dataContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/04/17.
//

import Foundation

public protocol DataContract {
    func onTaskError(ourMemoryErr:OurMemoryErrorData)
}
