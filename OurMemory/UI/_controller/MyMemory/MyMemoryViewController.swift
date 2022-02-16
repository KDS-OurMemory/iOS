//
//  MyMemoryViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit
import OurMemoryTask

class MyMemoryViewController: BaseViewController {

    var myMemoryCtl:MyMemoryContract?
    @IBOutlet weak var addScheduleBtn: UIButton!
    @IBOutlet weak var sharedBtn: UIButton!
    @IBOutlet weak var dateLeftBtn: UIButton!
    @IBOutlet weak var datePickerBtn: UIButton!
    @IBOutlet weak var dateRightBtn: UIButton!
    @IBOutlet weak var updownView: UIView!
    @IBOutlet weak var calView: UICollectionView!
    
    override func getDataContract() -> DataContract? {
        return self.myMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            myMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyMemory, view: self, data: data) as? MyMemoryContract
            
            addScheduleBtn.addAction { p1 in
                self.myMemoryCtl?.actionAddSchduleBtn(sender: p1 as! UIButton)
            }
            
            sharedBtn.addAction { p1 in
                self.myMemoryCtl?.actionSelectSharedBtn(sender: p1 as! UIButton)
            }
            
            dateLeftBtn.addAction { p1 in
//                self.myMemoryCtl.act
            }
            
            datePickerBtn.addAction { p1 in
//                self.myMemoryCtl
            }
            
            dateRightBtn.addAction { p1 in
//                self.myMemoryCtl
            }
            
        }
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_ADDSCHEDULE:
            self.navigate(vc, data: data)
            break
        case .NEXTViEW_SHAREDLIST:
            break
        default:
            break
        }
    }

}

extension MyMemoryViewController: MyMemoryView {
    
}
