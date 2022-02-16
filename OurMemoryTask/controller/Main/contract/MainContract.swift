//
//  mainContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/02/26.
//

import Foundation
import UIKit

public protocol MainContract:BaseCollectionAdapterContract {
    
    /**
     * 내가 속한 방목록 
     */
    func tryGetMyRommListRequest()
}
