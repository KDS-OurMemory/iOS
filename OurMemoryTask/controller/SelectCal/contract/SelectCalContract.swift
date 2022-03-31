//
//  SelectCalContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/03/18.
//

import Foundation

public protocol SelectCalContract: BaseCollectionAdapterContract {
    
    func actionCancelBtn()
    func actionConfirmBtn()
    func actionCalPlusBtn()
    func actionCalMinusBtn()
}
