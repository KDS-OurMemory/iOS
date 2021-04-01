//
//  IntroViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class IntroViewController: BaseViewController {
    
//    var introCtl: IntroContract = CtlMaker().createDataControllerWithContract(contract: ctls.eContractIntro, view: self) as! IntroContract
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = RoomDetailViewController().inittailizeSubViewClass()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
