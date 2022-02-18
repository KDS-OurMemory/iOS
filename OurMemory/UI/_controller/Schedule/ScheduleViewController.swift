//
//  ScheduleViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/02/17.
//

import UIKit

class ScheduleViewController: BaseViewController {

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

extension ScheduleViewController: ScheduleView {
    
}
