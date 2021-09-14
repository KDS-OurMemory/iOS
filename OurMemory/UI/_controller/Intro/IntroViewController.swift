//
//  IntroViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class IntroViewController: BaseViewController {
    
    var introCtl:IntroContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.introCtl == nil {
            self.prepareView()
        }
        
    }
    
    private func prepareView() {
        introCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractIntro, view: self) as? IntroContract)
        if let ctl = self.introCtl {
            ctl.requestIntroData()
        }
    }
    
}

extension IntroViewController: IntroView {
    
    // MARK: viewContract
    
    func showNEXTVC(vc:NEXTVIEW,data:[NSObject]?) {
        switch vc {
        case .NEXTVIEW_MAIN:
            self.navigate(NEXTVIEW.NEXTVIEW_MAIN)
            break
        case .NEXTVIEW_LOGIN:
            self.navigate(NEXTVIEW.NEXTVIEW_LOGIN)
            
        default:
            break
        }
    }
}
