//
//  IntroCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import UIKit

class IntroCtl: BaseCtl {

    let introModel = IntroModel()
    override func __initWithData__(data: Any?) {
        self.introModel.initWithCallback{ valideCase in
            switch valideCase
            {
            case .KNOWN_CASE:
                break
            case .SUCCESS_CASE:
                
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_LOGIN, data: nil)
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_POP, data: nil)
                break
            default:
                break
            }
        }
    }
    
// MARK: private
    
    fileprivate func callShowNextVC(vc:NEXTVIEW, data:Any?) {
            switch vc {
            case .NEXTVIEW_POP:
                self.view.showNextVC(vc: vc, data: nil)
            case .NEXTVIEW_LOGIN:
                self.view.showNextVC(vc:vc, data: nil)
                break
            default:
                break
            }
        
    }
}


