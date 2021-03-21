//
//  IntroCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import UIKit

class IntroCtl: BaseCtl {

    let netModel = IntroNetModel()
    
    override func __init__() {
        
    }
}

extension IntroCtl: IntroContract {
    
    public func requestIntroData() {
        self.netModel.tryRequestRestfulAPI { (flag) in
            if flag == true {
                
            }else {
                
            }
        }
    }
    
}
