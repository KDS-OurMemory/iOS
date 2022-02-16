//
//  MyProfileViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class MyProfileViewController: BaseViewController {

    var myMemoryCtl:MyMemoryContract?
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var itemContainer: UIView!
    let topView:TopView = TopView()
    
    override func getDataContract() -> DataContract? {
        return self.myMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            myMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyMemory, view: self, data: data) as? MyMemoryContract
        }
        topView.setTitle(title: "마이페이지")
        topViewContainer.addSubview(topView)
    }

}
