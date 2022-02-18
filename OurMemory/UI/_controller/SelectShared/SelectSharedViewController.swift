//
//  SelectSharedViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class SelectSharedViewController: BaseViewController {

    var myMemoryCtl:SelectSharedContract?
    
    override func getDataContract() -> DataContract? {
        return self.myMemoryCtl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackgroundDimColor()
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            myMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyMemory, view: self, data: data) as? SelectSharedContract
        }
    }

}

extension SelectSharedViewController:SelectSharedView {
    func dismissPopup() {
        self.dismiss(animated: true) {
           
        }
    }
}
