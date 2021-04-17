//
//  IntroViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class IntroViewController: BaseViewController,IntroView {
    
    var introCtl:IntroContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.introCtl == nil {
            self.prepareView()
        }
        
    }
    
    override func onReadyPushVC() {
        
    }
    
    func prepareView() {
        introCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractIntro, view: self) as? IntroContract)
        if let ctl = self.introCtl {
            ctl.requestIntroData()
        }
    }
    
    // MARK: viewContract
    
    func showNEXTVC(vc:NEXTVIEW,data:[NSObject]?) {
        switch vc {
        case NEXTVIEW.NEXTVIEW_MAIN:
            IntroViewController().navigate(NEXTVIEW.NEXTVIEW_MAIN)
            break
        case .NEXTVIEW_LOGIN:
            IntroViewController().navigate(NEXTVIEW.NEXTVIEW_LOGIN)
        default:
            break
        }
    }
}
