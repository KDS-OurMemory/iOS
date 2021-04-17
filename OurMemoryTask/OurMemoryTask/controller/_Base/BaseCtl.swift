//
//  baseCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/02/26.
//

import UIKit

class BaseCtl {

    var view:viewContract!
    
    init(view:viewContract) {
        self.view = view
        self.__init__()
    }
    
    func __init__() {
        print("재정의 매소드")
    }
}
