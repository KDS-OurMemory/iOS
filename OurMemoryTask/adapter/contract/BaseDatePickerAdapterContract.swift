//
//  BaseDatePickerContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/07.
//

import Foundation
import UIKit

public protocol BaseDatePickerAdapterContract:DataContract {
    /**
     *  PickerView 컨트롤단 세팅
     */
    func setDatePickerWithAdpater(adapter:BaseDatePickerAdapter,pickerView:UIPickerView)
}
