//
//  SelectSharedViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class SelectSharedViewController: BaseViewController {

    var myMemoryCtl:MyMemoryContract?
    
    override func getDataContract() -> DataContract? {
        return self.myMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            myMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyMemory, view: self, data: data) as? MyMemoryContract
        }
    }

}
