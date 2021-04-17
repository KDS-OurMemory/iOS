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

// MARK: dataContract

extension IntroCtl: IntroContract {
    
    func requestIntroData() {
        self.netModel.tryRequestLoginIntro { (flag) in
            if flag {
                self.view.showNEXTVC(vc: NEXTVIEW.NEXTVIEW_MAIN, data: nil)
            }else {
                self.view.showNEXTVC(vc: NEXTVIEW.NEXTVIEW_LOGIN, data: nil)
            }
        }
    }
    
}
