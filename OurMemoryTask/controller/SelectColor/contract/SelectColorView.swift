//
//  SelectColorView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation
import UIKit

public protocol SelectColorView:ViewContract {
    func updateColors(colors:[UIColor])
}
