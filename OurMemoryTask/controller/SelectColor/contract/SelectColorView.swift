//
//  SelectColorView.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation
import UIKit

public protocol SelectColorView:PopupContract {
    func updateColors(colors:[UIColor])
}
