//
//  SelectCalenderViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/03/18.
//

import UIKit

class SelectCalenderViewController: BaseViewController {

    var selectCalCtl:SelectCalContract?
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var dateInfoLbl: UILabel!
    @IBOutlet weak var popCalenderCollectionView: UICollectionView!
    @IBOutlet weak var calPrevBtn: UIButton!
    @IBOutlet weak var yearPickerBtn: UIButton!
    @IBOutlet weak var calNextBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func getDataContract() -> DataContract? {
        return self.selectCalCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            selectCalCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectCal, view: self, data: nil) as? SelectCalContract
        }
    }

    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_POP:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        default:
            break
        }
    }
}


extension SelectCalenderViewController: SelectCalView {
    
    func updateSelectDateData(data: CalSelectDateDataBinder) {
        
    }
    
    
}
