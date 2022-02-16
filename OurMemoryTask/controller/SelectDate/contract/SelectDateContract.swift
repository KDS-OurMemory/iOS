//
//  SelectDateContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation
import UIKit

public protocol SelectDateContract:BaseDatePickerAdapterContract {
    
    func selectAlarmIdx(idx:Int)
    
    func actionConfirmBtn(sender:UIButton)
    func actionCancelBtn(sender:UIButton)
}
