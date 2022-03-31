//
//  SelectCalView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/18.
//

import Foundation

public protocol SelectCalView:ViewContract {
    func updateSelectDateData(data:CalSelectDateDataBinder)
}
