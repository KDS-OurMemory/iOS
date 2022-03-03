//
//  collectionViewContract.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/05/23.
//

import Foundation
import UIKit

public protocol BaseCollectionAdapterContract:DataContract {
    
    /**
     *  collection 컨트롤단 세팅
     */
    func setCollectionWithAdpater(adapter:BaseCollectionAdapter)
}
