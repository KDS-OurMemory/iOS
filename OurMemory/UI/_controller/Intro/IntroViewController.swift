//
//  IntroViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class IntroViewController: BaseViewController {
    
    var introCtl:IntroContract?
    
    override func viewWillAppear(_ animated: Bool) {
        self.prepareViewWithData(data: nil)
        super.viewWillAppear(animated)
    }
    
    override func getDataContract() -> DataContract? {
        return self.introCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            introCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractIntro, view: self,data: data) as? IntroContract)
            
        }
    }
    
    override func showNextVC(vc:NEXTVIEW,data:Any?) {
        switch vc {
        case .NEXTVIEW_POP,.NEXTVIEW_LOGIN:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
        default:
            break
        }
    }
    
}

extension IntroViewController: IntroView {
    
    // MARK: viewContract
    
    
}
