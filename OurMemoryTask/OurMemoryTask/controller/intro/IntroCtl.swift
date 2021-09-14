//
//  IntroCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2021/03/20.
//

import UIKit

class IntroCtl: BaseCtl {

    let introModel = IntroModel()
    
    override func __init__() {
        self.introModel.initWithCallback{ valideCase in
            switch valideCase
            {
            case .KNOWN_CASE:
                break
            case .NOTCONNECTNET_CASE:
                break
            case .REQUESTERROR_CASE:
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_LOGIN)
                break
            case .SUCCESS_CASE:
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_MAIN)
                break
            case .FAILE_CASE:
                self.callShowNextVC(vc:NEXTVIEW.NEXTVIEW_LOGIN)
                break
            }
        }
    }
    
// MARK: private
    
    func callShowNextVC(vc:NEXTVIEW) {
        DispatchQueue.main.async {
            switch vc {
            case .NEXTVIEW_LOGIN:
                self.view.showNEXTVC(vc:vc, data: nil)
                break
            case .NEXTVIEW_MAIN:
                self.view.showNEXTVC(vc:vc, data: nil)
                break
            default:
                break
            }
        }
    }
}

// MARK: dataContract

extension IntroCtl: IntroContract {
    
    func requestIntroData() {
        introModel.tryAutoLoginRequest()
    }
    
}


