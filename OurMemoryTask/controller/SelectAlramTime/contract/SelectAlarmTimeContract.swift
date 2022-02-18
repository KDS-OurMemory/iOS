//
//  SelectAlramTimeContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation
import UIKit

public protocol SelectAlarmContract:DataContract {
    func selectAlarmIdx(idx:Int)
    func actionCancelBtn(sender:UIButton)
    func actionConfirmBtn(sender:UIButton)
}
