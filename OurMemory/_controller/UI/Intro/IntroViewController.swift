//
//  IntroViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

protocol IntroViewControllerInterface {
    var introCtl:IntroContract { get }
}

class IntroViewController: UIViewController,IntroViewControllerInterface {
    
    var introCtl: IntroContract = CtlMaker().createDataControllerWithContract(contract: ctls.eContractIntro, view: self) as! IntroContract
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension IntroViewController: IntroView {
    
}
