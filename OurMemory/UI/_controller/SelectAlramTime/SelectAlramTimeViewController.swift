//
//  SelectAlramTimeViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class SelectAlramTimeViewController: BaseViewController {

    @IBOutlet weak var selectedAlarmInfoLbl: UILabel!
    @IBOutlet weak var alarmTitleLbl: UILabel!
    @IBOutlet weak var alarmItemScrollView: BaseScrollView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var selectAlramTimeCtl:SelectAlramContract?
    var selectAlarmBlock:((String) -> Void)?
    var alarmBtnList:[SelectBoxButton] = []
    
    override func getDataContract() -> DataContract? {
        return self.selectAlramTimeCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            selectAlramTimeCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectAlramTime, view: self, data: data) as? SelectAlramContract
        }
    }
    
    func setSelectAlarmBlock(block:(@escaping (String) -> Void)) {
        selectAlarmBlock = block
    }

}

extension SelectAlramTimeViewController: SelectAlramView {
    
    func updateAlarmList(alarmList:[String]) {
        for alarm in alarmList {
            let selectBoxBtn:SelectBoxButton = SelectBoxButton()
            selectBoxBtn.setTitle(alarm, for: .normal)
            alarmItemScrollView.addVerScrollSubView(subView: selectBoxBtn, viewSize: selectBoxBtn.frame.size, verPadding: 25)
            alarmBtnList.append(selectBoxBtn)
            selectBoxBtn.addAction { p1 in
                if let ctl = self.selectAlramTimeCtl {
                    ctl.selectAlarmIdx(idx: self.alarmBtnList.firstIndex(of: selectBoxBtn)!)
                }
            }
        }
    }
    
    func updateSelectedAlarmTitle(title:String) {
        alarmTitleLbl.text = title
    }
    
    func applySelectedAlarms(alarms:String) {
        if let block = selectAlarmBlock {
            block(alarms)
        }
    }
    
    func enableSelectedAlarmIndex(idx:Int) {
        alarmBtnList[idx].isSelected = true
    }
    
    func disableSelectedAlarmIndex(idx:Int) {
        alarmBtnList[idx].isSelected = false
    }
    
    
}
