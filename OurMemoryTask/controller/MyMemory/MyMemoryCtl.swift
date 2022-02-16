//
//  MyMemoryCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit

class MyMemoryCtl: BaseCtl {

}


extension MyMemoryCtl:MyMemoryContract {
    func actionCalPlusBtn(sender:UIButton) {
        
    }
    
    func actionCalMinusBtn(sender:UIButton) {
        
    }
    
    func actionAddSchduleBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTVIEW_ADDSCHEDULE, data: nil)
        }
    }
    
    func actionSelectSharedBtn(sender:UIButton) {
        if let view = self.view as? MyMemoryView {
            view.showNextVC(vc: .NEXTViEW_SHAREDLIST, data: nil)
        }
    }
}
