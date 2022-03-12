//
//  OurMemoryContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import Foundation
import UIKit

public protocol MyMemoryContract:BaseCollectionAdapterContract {
    func actionCalPlusBtn(sender:UIButton)
    func actionCalMinusBtn(sender:UIButton)
    func actionAddSchduleBtn(sender:UIButton)
    func actionSelectSharedBtn(sender:UIButton)
    func selectScheduleIndex(index:Int)
    func reloadView()
}
